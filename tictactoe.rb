module TicTacToe
	class Game
		attr_reader :player1, :player2, :board
		def initialize(args={})
			@player1=args[:player1]
			@player2=args[:player2]
			@board=args[:board]

			new_game(@player1, @player2)			
		end
	
		
		private
		def new_game(player1, player2)
			#create new board
			game_setup(player1, player2)
			#play(player1, player2)

		end
	
		def game_setup (player1, player2)
			set_player(player1, player2)
		end

		def set_player(player1, player2)
			puts "Enter your name: "
			player1_name=gets.chomp
			puts "Randomly assigning your token..."
			tokens=["X", "O"].shuffle
			player1_token=tokens.first
			player2_token=tokens.last
			puts "#{player1_name}, your token is #{player1_token}."
			puts "#{player2}, your token is #{player2_token}."
			puts "Good luck, players!"
		end

		def play
					
		end

		def quit_game
			
		end

	end

	class Board
		attr_reader :cells, :board

		@@winners={
			:first_across=>[[0,0], [0,1], [0,2]],
			:second_across=>[[1,0], [1,1], [1,2]],
			:third_across=>[[2,0], [2,1], [2,2]],
			:first_down=>[[0,0], [1,0], [2,0]],
			:second_down=>[[0,1], [1,1], [2,1]],
			:third_down=>[[0,2], [1,2], [2,2]],
			:diags1=>[[0,0], [1,1], [2,2]],
			:diags2=>[[0,2], [1,1],[2,0]]
		}


		def initialize
			@board=[]
			create_cells
		end

		public

		def print_board
			puts "|#{@board[0].token}|#{@board[1].token}|#{@board[2].token}|"
			puts "======="
			puts "|#{@board[3].token}|#{@board[4].token}|#{@board[5].token}|"
			puts "======="
			puts "|#{@board[6].token}|#{@board[7].token}|#{@board[8].token}|"
		end

		private 

		def create_cells
			3.times do |i|
				3.times do |j|
					@board<<Cell.new(i, j)
				end
			end

			
		end

		class Cell
			attr_accessor :token
			def initialize(x, y, token=" ")
				@coordinates=[x,y]
				@token=token
			end

			def get_coorindates
				@coordinates
			end

			def token
				@token
			end

			def place_token(token)
				@token=token if cell_open?
			end

			def cell_open?
				token==" " ? true : false
			end
		end
	end

	class Player
		attr_reader :name, :token, :cells
		def initialize(args)
			@name=args[:name]
			@token=args[:token]
			@cells=[]
		end

		def place_token

		end
		private

	end

end

include TicTacToe
g=Game.new(:player1=>Player, :player2=>Player, :board=>Board.new())