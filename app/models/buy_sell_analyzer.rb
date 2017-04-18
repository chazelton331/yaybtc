class BuySellAnalyzer

  BUY  = :buy
  SELL = :sell
  HOLD = :hold

  RATINGS = [
    BUY,
    SELL,
    HOLD,
  ]

  def process
    {
      rating:     BUY,
      confidence: 0.75,
    }
  end

end
