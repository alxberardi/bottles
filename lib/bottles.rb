class Bottles
  def verse(number)
    Verse.new(number).to_s
  end

  class Verse
    def initialize(number)
      @number = number
    end

    def to_s
      "#{@number} bottles of beer on the wall, #{@number} bottles of beer.\n"\
      "Take one down and pass it around, #{@number - 1} bottles of beer on the wall.\n"
    end
  end
end
