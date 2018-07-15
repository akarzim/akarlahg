module Akarlahg
  ALPHA = {
    ipa:   %w[jɔ̃  jɛ̃  wɛ̃  waj wa u  œ̃  ɔ̃  ɛ̃  ɛj e  ɛ  aj ɑ̃  j ɥ y o ɔ i œ ø ə ɑ a],
    utf8:  %w[yõ  yũ  wĩ  wȧ  wa ů  ũ  õ  ĩ  ė  é  è  ȧ  ã  y ü u ô o i œ œ e â a],
    latin: %w[yoh yuh wih way wa hu uh oh ih ey eh he ay ah y u u o o i e e e a a]
  }.freeze

  BETA = {
    ipa:   %w[x  ɲ  ŋ  ks ɡz b ʃ d f ɡ ʒ k l m n p ʁ χ s t v w z],
    utf8:  %w[ḧ  ñ  ŋ  x  ẍ  b ȼ d f g j k l m n p r r s t v w z],
    latin: %w[qh nq ng ks gz b c d f g j k l m n p r r s t v w z]
  }.freeze

  ALPHABETA = ALPHA.merge(BETA) do |k, a, b|
    (k == :ipa ? (a + b) : (a.map(&:upcase) + b.map(&:upcase))) + a + b
  end.freeze

  refine String do
    def transpose(from:, to:)
      strip.
        gsub(/[^#{from_chars(from)} ]/, "").
        gsub(/(#{from_graphemes(from)})/, transpo_table(from: from, to: to))
    end

    def transpose_ipa(to:)
      transpose(from: :ipa, to: to)
    end

    def transpose_utf8(to:)
      transpose(from: :utf8, to: to)
    end

    def transpose_latin(to:)
      transpose(from: :latin, to: to)
    end

    private

    def from_chars(key)
      ALPHABETA[key].join.chars.uniq.join.freeze
    end

    def from_graphemes(key)
      ALPHABETA[key].join("|").freeze
    end

    def transpo_table(from:, to:)
      [from, to].each_with_object(Hash.new) { |k, hash| hash[k] = ALPHABETA[k] }.values.transpose.to_h
    end
  end
end
