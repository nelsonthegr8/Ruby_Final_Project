require_relative 'politician.rb'
module BackEndLogic
    #initialize variables
    attr_accessor :userInput, :userRespone, :mainMenuCharSelection, :ismainMenuLoop, :result;

    def create(arr)
        #initialize variables
        @userInput = "";
        @ismainMenuLoop = true;
        #create loop until user enters correct data
        while(@ismainMenuLoop)
            #display menu options and grab user input
            puts "What would you like to create?\n(P)olitician or (V)oter"
            @userInput = gets.chomp;
            @result = checkUserInputForCreateMenu(arr);
        end

        return @result
    end
    
    def update(arr)
        #display message to user and grab input
        puts "Who would you like to update?"
        itemToUpdate = gets.chomp;
        #initialize itterator variable
        i = 0;
        #create for loop to itterate through array passed in
        for user in arr
            #search for user name in array then update the users information
            if(itemToUpdate == user.name)

                puts "New name?";

                checkExistingNames(arr)

                arr[i].name = @userInput;

                if(user.type == "Politician")
                    @userInput = "";
                    while(@userInput.downcase != "d" && @userInput.downcase != "r" )
                        puts "New Party? (D)emocrat or (R)epublican"
                        @userInput = gets.chomp;
                    end
                else
                    @userInput = "";
                    compareArr = ["l","c","t","s","n"];
                    while(!compareArr.include? @userInput.downcase)
                        puts "New Politics?\n(L)iberal, (C)onservative, (T)ea Party, (S)ocialist, or (N)eutral"
                        @userInput = gets.chomp;
                    end
                end

                puts "User Found and Updated"
                break;
            end
            i += 1;
        end

    end
    
    def list(arr)
        #create for loop to display the users in the array 
        for politician in arr
            puts "* #{politician.type}, #{politician.name}, #{politician.party}"; 
        end
    end
    
    def remove(arr)

        puts "Who would you like to delete?"
        itemToDelete = gets.chomp;

        puts   "# If the name matches a known person\nAre you sure?\n(Y)es Press any other button for No"
        userDecision = gets.chomp;

        isUserSure = userDecision.downcase == "y" ? true : false;
        isUserFound = false;
        i = 0;

        if(isUserSure)
            for user in arr
                if(itemToDelete == user.name)
                    arr.delete_at(i) 
                    puts "User Found and Deleted"
                    isUserFound = true;
                    break;
                end
                i += 1;
            end
        end

        if(!isUserFound && isUserSure)
            puts "User not found"
        end
        
        return arr;
    end

    #create function that checks the user input and filters it
    def checkUserInputForCreateMenu(arr)
        #initialize mainmenu selection characters array
        @mainMenuCharSelection = ["p","v"];
        #check user input for input validation
        if(@mainMenuCharSelection.include? @userInput.downcase)
            case @userInput.downcase
            when "p"
                puts "Name?";

                checkExistingNames(arr);

                name = @userInput;

                @userInput = "";
                while(@userInput.downcase != "d" && @userInput.downcase != "r" )
                    puts "Party? (D)emocrat or (R)epublican"
                    @userInput = gets.chomp;
                end

                party = @userInput == "d" ? "Democrat" : "Republican";
                p = Politician.new(name,party,"Politician")
        
                @ismainMenuLoop = false;
                return p;
            when "v"
                puts "Name?"
                
                checkExistingNames(arr);

                name = @userInput;

                @userInput = "";
                compareArr = ["l","c","t","s","n"];
                while(!compareArr.include? @userInput.downcase)
                    puts "Politics?\n(L)iberal, (C)onservative, (T)ea Party, (S)ocialist, or (N)eutral"
                    @userInput = gets.chomp;
                end

                politics = "";
                case @userInput.downcase
                when compareArr[0]
                    politics = "Liberal";
                when compareArr[1]
                    politics = "Conservative"
                when compareArr[2]
                    politics = "Tea Party"
                when compareArr[3]
                    politics = "Socialist"
                when compareArr[4]
                    politics = "Neutral"
                else
                    puts "Wrong choice"
                end
                p = Politician.new(name,politics,"Voter")
        
                @ismainMenuLoop = false;
                return p;
            else
                puts "entry unkown! Try again! \n\n"
            end
        else
            puts "Please enter a valid choice from the menu options! You chose (#{@userInput}) \n\n";
        end
    end

    def checkExistingNames(arr)
        isUserInDB = false;
        isEndLoop = false;

        @userInput = gets.chomp;
        
        while(!isEndLoop)
            isUserInDB = false;

            for user in arr
                if(user.name == @userInput)
                    puts "Error: User already in system! Please try a different name."
                    @userInput = gets.chomp;
                    isUserInDB = true;
                    break;
                end
            end

            if(!isUserInDB)
                isEndLoop = true;
            end
        end
    end
   
end
