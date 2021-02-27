#include back end logic module
require_relative "backEndLogic.rb"
include BackEndLogic
#create main menu module
module MainMenu
    #initialize variables
    attr_accessor :userInput, :userRespone, :mainMenuCharSelection, :ismainMenuLoop, :politicians, :voters;
    #create class that loops through main menu untill user presses e
    def main
        #initialize main loop boolean value
        @ismainMenuLoop = true;
        @politicians = [];
        @voters = [];
        #loop through main menu until user decides to exit
        while(@ismainMenuLoop)
            showMainMenu();
        end
    end
    #function that displays main menu
    def showMainMenu
        #clear user input field
        @userInput = "";
        #display main menu respond to user and wait for response
        @userRespone = "Welcome To Voter Simulation! \n\nWhat would you like to do?\n(C)reate, (L)ist, (U)pdate, (D)elete or (E)xit"
        puts @userRespone;
        @userInput = gets.chomp;
        #call check user input after coming out of the loop
        checkUserInput();
    end
    #create function that checks the user input and filters it
    def checkUserInput
        #initialize mainmenu selection characters array
        @mainMenuCharSelection = ["c","l","u","d","e"];
        #check user input for input validation
        if(@mainMenuCharSelection.include? @userInput.downcase)
            case @userInput.downcase
            when "c"
                result = BackEndLogic.create(politicians);
                
                politicians << result;
            when "l"
                BackEndLogic.list(politicians);
            when "u"
                BackEndLogic.update(politicians);
            when "d"
                result = BackEndLogic.remove(politicians);
            when "e"
                @ismainMenuLoop = false;
            else
                puts "entry unkown! Try again! \n\n"
            end
        else
            puts "Please enter a valid choice from the menu options! You chose (#{@userInput}) \n\n";
        end
    end
end