module TicTacToe
	class Game
		attr_reader :players, :board

		@@player_count=0

		def initialize(args={})
			@players=[]
			@players[0]=args[:player1]
			@players[1]=args[:player2]
			@board=args[:board]
			@current_player_id=0
		#	new_game(@players)			
			board.get_cell_number([1,2])
		end
	
		private
		def new_game(players)
			game_setup(players)
			play(players)
		end
	
		def game_setup (players)
			player_info=set_player
			puts create_players(player_info, players)
			puts "Good luck, players!"
		end

		def set_player
			player1_name=set_player_name
			player2_name=set_player_name
			puts "Randomly assigning your tokens..."
			tokens=["X", "O"].shuffle
			player1_token=tokens.first
			player2_token=tokens.last

			return [[player1_name, player1_token], [player2_name, player2_token]]
		end

		def set_player_name
			@@player_count+=1
			puts "Player #{@@player_count}, enter your name: "
			player_name=gets.chomp
		end

		def create_players(info, players)
			players[0]=players[0].new(:name=>info[0][0], :token=>info[0][1])
			players[1]=players[1].new(:name=>info[1][0], :token=>info[1][1])
			return "created players #{players[0].name} with token #{players[0].token} and #{players[1].name} with token #{players[1].token}"
		end

		def play(players)
			while not_empty? do
				board.print_board
				temp=nil
				until temp!=nil do
					position=current_player.set_token_position
					coords=board.find_cell_position(position)
					cell=board.find_cell(coords)
					temp=cell.place_token(current_player) 
				end
				add_cells(cell, position)
				puts "#{current_player.name} placed #{current_player.token} at #{cell.get_coordinates}"
				
				if winner? 
					board.print_board
					break
				end
				switch!
			end	

			if board.is_full?
				board.print_board
				puts "It's a draw!" 
			end
		end

		def add_cells(cell, position)
			board.add_cell(cell, position)
			current_player.add_cell(cell)
		end

		def not_empty?
			@board.not_empty?
		end

		def board
			@board
		end

		def winner?
			winner=false;
			cells=current_player.get_player_cells
			p_cells=cells.map{|i| i.get_coordinates}

			board.winners.each do |win|
				winning_combo=p_cells & win
				winner=winning_combo.length==3
				if winner
					puts "#{current_player.name} has won!"
					break
				end	
			end
			winner
		end

		def other_player
			1-@current_player_id
		end

		def switch!
			@current_player_id=other_player
		end

		def current_player
			@players[@current_player_id]
		end

		def quit_game
			false
		end

	end

	class Board
		attr_reader :board

		@@winners=[
			[[0,0], [0,1], [0,2]],
			[[1,0], [1,1], [1,2]],
			[[2,0], [2,1], [2,2]],
			[[0,0], [1,0], [2,0]],
			[[0,1], [1,1], [2,1]],
			[[0,2], [1,2], [2,2]],
			[[0,0], [1,1], [2,2]],
			[[0,2], [1,1],[2,0]]
		]
		def initialize
			@board=[]
			create_cells
		end

		public
		def winners
			@@winners
		end

		def print_board
			puts "|#{@board[0].token}|#{@board[1].token}|#{@board[2].token}|"
			puts "======="
			puts "|#{@board[3].token}|#{@board[4].token}|#{@board[5].token}|"
			puts "======="
			puts "|#{@board[6].token}|#{@board[7].token}|#{@board[8].token}|"
		end
	
		def get_board
			@board		
		end

		def add_cell(cell, pos)
			@board[pos-1]=cell			
		end

		def not_empty?
			!@board.all?{|cell| cell.token!=" "}
		end

		def is_full?
			@board.none?{|cell| cell.token==" "}
		end

		def get_cell_number(coordinates)
			p @board
		end
		def find_cell_position(coordinate)
			if coordinate<=3
				y=0
				x=coordinate-1
			elsif coordinate<=6
				y=1
				x=coordinate-4
			elsif coordinate<=9
				y=2
				x=coordinate-7
			end
			[x,y]
		end

		def find_cell(coordinates=[])
			 cell=@board.select do |cell|
				cell.get_coordinates==coordinates
			end
			cell[0]
		end

		private 
		def create_cells
			3.times do |i|
				3.times do |j|
					@board<<Cell.new(j, i)
				end
			end
		end

		class Cell
			attr_accessor :token
			def initialize(x, y, token=" ")
				@coordinates=[x,y]
				@token=token
			end

			def get_coordinates
				@coordinates
			end

			def token
				@token
			end

			def place_token(obj)
				if cell_open?
					@token=obj.token
				else
					puts "Cannot place token at this position; Try Again."
				end
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

		def name
			@name
		end

		def add_cell (cell)
			@cells<<cell
		end

		def token
			@token
		end

		def get_player_cells
			@cells
		end

		def set_token_position
			puts "#{self.name}, select your position! (1 through 9)"
			position=0
			until position>0 and position<10 do
				position=gets.to_i
				if position<=0 or position>10
					puts "Invalid position! Select your position!"
				end
			end
			position
		end
	end
end

include TicTacToe
g=Game.new(:player1=>Player, :player2=>Player, :board=>Board.new())