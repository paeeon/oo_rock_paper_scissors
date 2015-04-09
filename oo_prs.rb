# PRS is a game between two players. 
# Both players pick a hand of either "paper", "rock" or "scissors". 
# Then the two hands are compared and it's either a tie (if the hands are the same) 
# or p > r, r > s and s > p. 

class Player
  attr_accessor :choice

  def paper?
    (self.choice == 'p') ? true : false
  end

  def rock?
    (self.choice == 'r') ? true : false
  end

  def scissors?
    (self.choice == 's') ? true : false
  end

end

class Computer < Player
  def pick_choice
    self.choice = Game::CHOICES.keys.sample
  end
end

class Human < Player
  def pick_choice
    begin
      puts "Choose one: P/R/S"
      self.choice = gets.chomp.downcase
    end until Game::CHOICES.keys.include?(choice)
  end
end

class Game
  CHOICES = {'p' => 'Paper', 'r' => 'Rock', 's' => 'Scissors'}
  attr_reader :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def determine_winner
    if (human.paper? && computer.rock?) || 
      (human.rock? && computer.scissors?) || 
      (human.scissors? && computer.paper?)
      human
    elsif (computer.paper? && human.rock?) || 
      (computer.rock? && human.scissors?) || 
      (computer.scissors? && human.paper?)
      computer
    end
  end

  def declare_winner
    if determine_winner == human
      puts "#{CHOICES[human.choice]} beats #{CHOICES[computer.choice].downcase}! You win!"
    elsif determine_winner == computer
      puts "#{CHOICES[computer.choice]} beats #{CHOICES[human.choice].downcase}! Computer wins!"
    else
      puts "You chose #{CHOICES[human.choice].downcase} and the computer chose #{CHOICES[computer.choice].downcase}. It's a tie!"
    end
  end

  def play_game
    human.pick_choice
    computer.pick_choice
    declare_winner
  end

end

begin
  prs = Game.new.play_game
  puts "Want to play again? Y/N"
  play_again = gets.chomp.downcase
end until play_again != 'y'