# PRS is a game between two players. 
# Both players pick a hand of either "paper", "rock" or "scissors". 
# Then the two hands are compared and it's either a tie (if the hands are the same) 
# or p > r, r > s and s > p. 

class Player
  attr_accessor :choice
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
    self.choice
  end
end

class Game
  CHOICES = {'p' => 'Paper', 'r' => 'Rock', 's' => 'Scissors'}
  attr_reader :human, :computer
  attr_writer :winner

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def determine_winner
    if (human.choice == 'p' && computer.choice == 'r') || 
      (human.choice == 'r' && computer.choice == 's') || 
      (human.choice == 's' && computer.choice == 'p')
      human
    elsif (computer.choice == 'p' && human.choice == 'r') || 
      (computer.choice == 'r' && human.choice == 's') || 
      (computer.choice == 's' && human.choice == 'p')
      computer
    else
      winner = nil
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