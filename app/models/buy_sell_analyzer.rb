#
# "The Algorithm"
#   This will probably change significantly in the next
#   year...  V1 goal is to get something that will work
#   in a very basic sense, and that is tunable over a
#   long period.
#
class BuySellAnalyzer

  # look at last 6 hours to start
  HOURS = 6

  BUY  = :buy
  SELL = :sell
  HOLD = :hold

  RATINGS = [
    BUY,
    SELL,
    HOLD,
  ]

  def initialize
    @bitcoin_rating = {
      first_price:         nil,
      last_price:          nil,
      previous_price:      nil,
      current_price:       nil,
      trends_up:           0,
      trends_down:         0,
      percent_change:      0.0,
      percent_change_60:   0.0,
      price_at_60:         0.0,
      percent_change_120:  0.0,
      price_at_120:        0.0,
      percent_change_180:  0.0,
      price_at_180:        0.0,
      percent_change_240:  0.0,
      price_at_240:        0.0,
      percent_change_300:  0.0,
      price_at_300:        0.0,
      percent_change_360:  0.0,
      price_at_360:        0.0,
    }

    @sentiment_rating = {
      previous_sentiment: nil,
      current_sentiment:  nil,
    }
  end

  def process
    calculate_rating_and_confidence(price_analysis, sentiment_analysis).tap do |analysis|
      if analysis[:confidence] >= 0.75
        User.where(auto_buy_sell_enabled: true).each do |user|
          case analysis[:rating]
          when BUY
            user.buy_bitcoin
          when SELL
            user.sell_bitcoin
          when HOLD
            # NOOP
          end
        end
      end
    end
  end

  private

  def price_analysis
    recent_bitcoin_statuses = BitcoinStatus.order("created_at DESC")
                                           .limit(HOURS * 60)
                                           .pluck(:price)


    recent_bitcoin_statuses.each_with_index do |price, index|
      if index == 0
        @bitcoin_rating[:first_price   ] = price
        @bitcoin_rating[:previous_price] = price
      else
        calculate_price_trends(price)
        @bitcoin_rating[:previous_price] = price
      end

      if index + 1 == 60
        @bitcoin_rating[:price_at_60      ]  = price
        @bitcoin_rating[:percent_change_60]  = calcuate_percentage(price, @bitcoin_rating[:first_price])
      elsif index + 1 == 120
        @bitcoin_rating[:price_at_120      ] = price
        @bitcoin_rating[:percent_change_120] = calcuate_percentage(price, @bitcoin_rating[:price_at_60])
      elsif index + 1 == 180
        @bitcoin_rating[:price_at_180      ] = price
        @bitcoin_rating[:percent_change_180] = calcuate_percentage(price, @bitcoin_rating[:price_at_120])
      elsif index + 1 == 240
        @bitcoin_rating[:price_at_240      ] = price
        @bitcoin_rating[:percent_change_240] = calcuate_percentage(price, @bitcoin_rating[:price_at_180])
      elsif index + 1 == 300
        @bitcoin_rating[:price_at_300      ] = price
        @bitcoin_rating[:percent_change_300] = calcuate_percentage(price, @bitcoin_rating[:price_at_240])
      elsif index + 1 == 360
        @bitcoin_rating[:price_at_360      ] = price
        @bitcoin_rating[:percent_change_360] = calcuate_percentage(price, @bitcoin_rating[:price_at_300])
      end

      if (index + 1) == recent_bitcoin_statuses.count
        @bitcoin_rating[:last_price] = price
      end
    end

    @bitcoin_rating[:percent_change] = calcuate_percentage(@bitcoin_rating[:last_price], @bitcoin_rating[:first_price])
  end

  def calcuate_percentage(x, y)
    1.0 - x.to_f/y.to_f
  end

  def calculate_price_trends(current_price)
    key = (current_price - @bitcoin_rating[:previous_price] > 0) ? :trends_up : :trends_down
    @bitcoin_rating[key] += 1
  end

  def sentiment_analysis
    recent_sentiment_statuses = SentimentStatus.order("created_at DESC")
                                               .limit(6)
                                               .pluck(:score)
  end

  def calculate_rating_and_confidence(price, sentiment)
    # trends_up:           0
    # trends_down:         0
    # percent_change:      0.0
    # percent_change_60:   0.0
    # percent_change_120:  0.0
    # percent_change_180:  0.0
    # percent_change_240:  0.0
    # percent_change_300:  0.0
    # percent_change_360:  0.0

    # how many trends up?
    # how many trends down?
    # difference in trends up vs. trends down?
    # how many of the % changes were up vs. down?
    # is the overal % up?
    # how sharply is the % up?

    {
      rating:     BUY,
      confidence: 0.75,
    }
  end
end
