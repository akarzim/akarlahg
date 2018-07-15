require_relative "test_helper"

module Akarlahg
  using Akarlahg

  describe String do
    let(:ipa_set_str)   { ALPHABETA[:ipa].join(" ") }
    let(:utf8_set_str)  { ALPHABETA[:utf8].join(" ") }
    let(:latin_set_str) { ALPHABETA[:latin].join(" ") }

    let(:unicode_ipa)   { "ɑ ə ø œ ɛ ɔ ɥ" }
    let(:unicode_utf8)  { "â e œ œ è o ü".freeze }
    let(:unicode_latin) { "a e e e he o u".freeze }

    let(:diacritics_ipa)   { "ɑ̃ œ̃ ɛ̃ ɔ̃".freeze }
    let(:diacritics_utf8)  { "ã ũ ĩ õ".freeze }
    let(:diacritics_latin) { "ah uh ih oh".freeze }

    describe "latin" do
      describe "with unicode characters" do
        subject { unicode_ipa.transpose_ipa(to: :latin) }

        it "returns latin charcters" do
          _(subject).must_equal unicode_latin
        end
      end

      describe "with diacritics characters" do
        subject { diacritics_ipa.transpose_ipa(to: :latin) }

        it "returns latin charcters" do
          _(subject).must_equal diacritics_latin
        end
      end

      describe "with alphabeta" do
        subject { ipa_set_str.transpose_ipa(to: :latin) }

        it "returns latin ALPHABETA" do
          _(subject).must_equal latin_set_str.downcase
        end
      end

      describe "from utf8" do
        subject { utf8_set_str.transpose_utf8(to: :latin) }

        it "returns latin ALPHABETA" do
          _(subject).must_equal latin_set_str
        end
      end
    end

    describe "utf8" do
      describe "with unicode characters" do
        subject { unicode_ipa.transpose_ipa(to: :utf8) }

        it "returns utf8 charcters" do
          _(subject).must_equal unicode_utf8
        end
      end

      describe "with diacritics characters" do
        subject { diacritics_ipa.transpose_ipa(to: :utf8) }

        it "returns utf8 charcters" do
          _(subject).must_equal diacritics_utf8
        end
      end

      describe "with alpabeta" do
        subject { ipa_set_str.transpose_ipa(to: :utf8) }

        it "returns utf8 ALPHABETA" do
          _(subject).must_equal utf8_set_str.downcase
        end
      end

      describe "from latin" do
        let(:lossy_map) do
          # akarlahg → akarlãg conversion is lossy
          { "ü" => "u", "ô" => "o", "œ" => "e", "â" => "a",
            "Ü" => "U", "Ô" => "O", "Œ" => "E", "Â" => "A" }.freeze
        end

        let(:lossy_graphemes) { lossy_map.keys.join("|").freeze }

        subject { latin_set_str.transpose_latin(to: :utf8) }

        it "returns utf8 ALPHABETA" do
          _(subject).must_equal utf8_set_str.gsub(/(#{lossy_graphemes})/, lossy_map)
        end
      end
    end
  end
end
