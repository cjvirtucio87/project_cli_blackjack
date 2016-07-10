require_relative 'controllers'
require_relative 'views'
require_relative 'models'

module BlackJackCLI

  def BlackJackCLI.main
    BlackJackCLI::GameController.new.play
  end
  
end

BlackJackCLI.main