class SentimentScorer

  def initialize
    @score = 0
  end

  def process(text)
    relevant_words = text.split(Language::WORD_BOUNDARY_REGEX).each do |word|
      lowercase_word = word.downcase

      if Language::NEGATIVE_SENTIMENT_WORDS.include?(lowercase_word)
        @score -= 1
      elsif Language::POSITIVE_SENTIMENT_WORDS.include?(lowercase_word)
        @score += 1
      end
    end

    { score: @score }
  end

end
