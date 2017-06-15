require 'singleton'
require 'forwardable'

class Bottles
  def verse(number)
    Verses[number].to_s
  end

  class Verses
    include Singleton

    class << self
      extend Forwardable
      def_delegators :instance, :[], :<<
    end

    def initialize
      @verses = []
    end

    def [](number)
      verse = @verses.find { |verse| verse.for?(number) }
      raise NoVerseError, "There is no verse for #{number}" if verse.nil?
      verse.new(number)
    end

    def << (verse)
      @verses << verse
    end

    class NoVerseError < StandardError
    end
  end

  class Verse
    def self.inherited(subclass)
      super
      Verses << subclass
    end

    def self.for?(number)
      raise NotImplementedError, 'Must be implemented by concrete verse'
    end

    def initialize(number)
      @number = number
    end

    def to_s
      "#{available_bottles} of beer on the wall, #{available_bottles} of beer.\n"\
      "#{action}, #{remaining_bottles} of beer on the wall.\n"
    end

    private

    def available_bottles
      "#{@number} bottles"
    end

    def action
      'Take one down and pass it around'
    end

    def remaining_bottles
      "#{@number - 1} bottles"
    end
  end

  class DefaultVerse < Verse
    def self.for?(number)
      number > 2
    end
  end

  class Verse2 < Verse
    def self.for?(number)
      number == 2
    end

    private

    def remaining_bottles
      '1 bottle'
    end
  end
end
