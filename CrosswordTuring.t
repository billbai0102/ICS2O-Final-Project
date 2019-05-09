%Bill Bai
%May 20, 2018
%Mr. Rosen
%This program is a replica of the classic game Crossword

import GUI %Imports Graphical User Interface

forward procedure mainMenu %Forwards mainMenu
forward proc randomPuzzleChooser %Forwards randomPuzzleChooser

%Declaration Section
var mainWin : int := Window.Open ("graphics:900;775;position:center;center") %Main window
var menuBtn, playBtn, instructionsBtn, timedBtn, exitBtn, untimedBtn, titleNum, endMsgVar, puzzleNum, intMinutes : int
var guess, answer, minutes : string
var winChecker : array 1 .. 16 of int
var seconds : real
var mouseX, mouseY, button, timedMode : int := 0
var introFont := Font.New ("serif:30") %Font used in introduction
var titleFont := Font.New ("serif:20") %Large font used for many procedures
var crosswordFont1 := Font.New ("serif:7") %Small font used for crossword hints
var crosswordFont2 := Font.New ("serif:15") %Medium font used for crossword answers

%Title - clears screen
procedure title
    cls %Clears screen
    if titleNum = 2 then %Title1 - used for userInput sections - timerUserInput & userInput
	locate (1, 15)
	put "Crossword User Input" %Draws title
    elsif titleNum = 1 then %Title2 - used for menu screens
	Font.Draw ("Crossword!", 390, 750, titleFont, 7) %Draws title
    end if
end title

%Title for crossword screens
procedure crosswordTitle
    cls %Clears screen
    if puzzleNum = 1 then %Title for puzzle1
	Font.Draw ("Computer Brands", 330, 750, titleFont, 7) %Draws title
    elsif puzzleNum = 2 then %Title for puzzle2
	Font.Draw ("Random Computer Facts", 300, 750, titleFont, 7) %Draws title
    elsif puzzleNum = 3 then %Title for puzzle3
	Font.Draw ("Computer", 220, 750, titleFont, 7) %Draws title
	Font.Draw ("parts", 250, 725, titleFont, 7) %Draws title
    end if
end crosswordTitle

%Displays ending message, credits, then stops music and closes the game
procedure goodbye
    titleNum := 1 %Uses title1 for title
    title %Refreshes screen
    for x : 1 .. 1000 %Draws background
	drawline (0 + x, 0, 0 + x, 775, 11) %Draws background as color 11
    end for
    Font.Draw ("Thank you for playing!", 320, 600, titleFont, black) %Ending text
    Font.Draw ("Program Written By:", 330, 550, titleFont, black) %Credits text
    Font.Draw ("BILL BAI", 390, 500, titleFont, 8) %Credits text
    delay (2500) %Delays for 2.5 seconds
    Music.PlayFileStop %Stops music
    GUI.CloseWindow (mainWin) %Closes window, and ends GUI
end goodbye

%Background music process
process music
    Music.PlayFileLoop ("CrosswordMusic.mp3") %Plays music in loop, until stopped
end music

%Introduction animation
procedure introduction
    titleNum := 1 %Uses title1 for title
    title %Refreshes screen
    menuBtn := GUI.CreateButton (400, 200, 100, "Start!", mainMenu) %Creates parameters for menuBtn
    fork music %Forks music, will be played all game, until stopped
    %Background
    for x : 0 .. 900 %Draws background
	drawline (0 + x, 0, 0 + x, 775, 76) %Colors background color 76
    end for
    %Animations
    for x : 0 .. 200 %Letter "C" slides from top
	drawfillbox (179, 809 - x, 241, 871 - x, 76) %Erase
	drawbox (180, 810 - x, 240, 870 - x, 7) %Box around the letter
	Font.Draw ("C", 197, 827 - x, introFont, 7) %Text
	delay (1) %Animations speed
    end for
    for x : 0 .. 200 %Letter "R" slides from top
	drawfillbox (300, 809 - x, 240, 871 - x, 76) %Erase
	drawbox (300, 810 - x, 240, 870 - x, 7) %Box around the letter
	Font.Draw ("R", 257, 827 - x, introFont, 7) %Text
	delay (1) %Animations speed
    end for
    for x : 0 .. 200 %Letter "O" slides from top
	drawfillbox (300, 809 - x, 360, 871 - x, 76) %Erase
	drawbox (300, 810 - x, 360, 870 - x, 7) %Box around the letter
	Font.Draw ("O", 317, 827 - x, introFont, 7) %Text
	delay (1) %Animations speed
    end for
    for x : 0 .. 200 %Letter "S" slides from top
	drawfillbox (420, 809 - x, 360, 871 - x, 76) %Erase
	drawbox (420, 810 - x, 360, 870 - x, 7) %Box around the letter
	Font.Draw ("S", 377, 827 - x, introFont, 7) %Text
	delay (1) %Animations speed
    end for
    for x : 0 .. 200 %Letter "S" slides from top
	drawfillbox (420, 809 - x, 480, 871 - x, 76) %Erase
	drawbox (420, 810 - x, 480, 870 - x, 7) %Box around the letter
	Font.Draw ("S", 437, 827 - x, introFont, 7) %Text
	delay (1) %Animations speed
    end for
    for x : 0 .. 200 %Letter "W" slides from top
	drawfillbox (540, 809 - x, 480, 871 - x, 76) %Erase
	drawbox (540, 810 - x, 480, 870 - x, 7) %Box around the letter
	Font.Draw ("W", 492, 827 - x, introFont, 7) %Text
	delay (1) %Animations speed
    end for
    for x : 0 .. 200 %Letter "O" slides from top
	drawfillbox (540, 809 - x, 600, 871 - x, 76) %Erase
	drawbox (540, 810 - x, 600, 870 - x, 7) %Box around the letter
	Font.Draw ("O", 557, 827 - x, introFont, 7) %Text
	delay (1) %Animations speed
    end for
    for x : 0 .. 200 %Letter "R" slides from top
	drawfillbox (660, 809 - x, 600, 871 - x, 76) %Erase
	drawbox (660, 810 - x, 600, 870 - x, 7) %Box around the letter
	Font.Draw ("R", 617, 827 - x, introFont, 7) %Text
	delay (1) %Animations speed
    end for
    for x : 0 .. 200 %Letter "D" slides from top
	drawfillbox (660, 809 - x, 720, 871 - x, 76) %Erase
	drawbox (660, 810 - x, 720, 870 - x, 7) %Box around the letter
	Font.Draw ("D", 677, 827 - x, introFont, 7) %Text
	delay (1) %Animations speed
    end for
    for x : 0 .. 360 %Letter "Y" slides from left
	drawfillbox (-61 + x, 580, 0 + x, 520, 76) %Erase
	drawbox (-60 + x, 580, 0 + x, 520, 7) %Box around the letter
	Font.Draw ("Y", -45 + x, 537, introFont, 7) %Text
	delay (1) %Animations speed
    end for
    for x : 0 .. 360 %Letter "B" slides from left
	drawfillbox (-60 + x, 580, -121 + x, 520, 76) %Erase
	drawbox (-60 + x, 580, -120 + x, 520, 7) %Box around the letter
	Font.Draw ("B", -102 + x, 537, introFont, 7) %Text
	delay (1) %Animations speed
    end for
    for x : 0 .. 480 %Letter "B" slides from right
	drawfillbox (900 - x, 580, 961 - x, 520, 76) %Erase
	drawbox (900 - x, 580, 960 - x, 520, 7) %Box around the letter
	Font.Draw ("B", 917 - x, 537, introFont, 7) %Text
	delay (1) %Animations speed
    end for
    for x : 0 .. 480 %Letter "I" slides from right
	drawfillbox (1021 - x, 580, 960 - x, 520, 76) %Erase
	drawbox (1020 - x, 580, 960 - x, 520, 7) %Box around the letter
	Font.Draw ("I", 983 - x, 537, introFont, 7) %Text
	delay (1) %Animations speed
    end for
    for x : 0 .. 480 %Letter "L" slides from right
	drawfillbox (1020 - x, 580, 1081 - x, 520, 76) %Erase
	drawbox (1020 - x, 580, 1080 - x, 520, 7) %Box around the letter
	Font.Draw ("L", 1037 - x, 537, introFont, 7) %Text
	delay (1) %Animations speed
    end for
    for x : 0 .. 480 %Letter "L" slides from right
	drawfillbox (1141 - x, 580, 1080 - x, 520, 76) %Erase
	drawbox (1140 - x, 580, 1080 - x, 520, 7) %Box around the letter
	Font.Draw ("L", 1097 - x, 537, introFont, 7) %Text
	delay (1) %Animations speed
    end for
    GUI.Show (menuBtn) %Allows user to press menuBtn, to go to next part
end introduction

%If user selects to have time, this procedure gets time from user
procedure timerUserInput
    seconds := 0 %Resets value for seconds to 0, incase
    var timerUserInputWin := Window.Open ("graphics:400;400;position:top;right") %Creates new window
    %Gets time
    loop
	titleNum := 2 %Sets title as titleNum2
	title %Refreshes screen
	locate (3, 1)
	put "Enter how many minutes you" .. %Prompt text
	locate (4, 1)
	put "want for your timer : " .. %Prompt text
	get minutes %Gets minutes
	%Error trap
	if strintok (minutes) = false then %If user inputs string rather than integer
	    locate (4, 1)
	    put "" %Erases previous text
	    locate (5, 1)
	    put "Please enter an INTEGER!" %Error text
	    delay (1000) %Waits 1 second, before continuing, to make sure user sees text
	end if
	exit when strintok (minutes) %Exits loop when entered minutes is an integer
    end loop
    intMinutes := strint (minutes) %Sets minutes (string) to intMinutes (integer)
    Window.Close (timerUserInputWin) %Closes window after user correctly enters information
end timerUserInput

%If user selects to have time, this procedure will count down time
procedure timerCounter
    locate (3, 80)
    put "" %Erases text
    locate (4, 80)
    put "" %Erases text
    locate (5, 80)
    put "" %Erases text
    if seconds >= 10 then
	locate (3, 80)
	put "Time left " : 5, intMinutes, ":", seconds %Outputs time
    else
	locate (3, 80)
	put "Time left " : 5, intMinutes, ":0", seconds %Outputs time
    end if
    delay (100) %Waits for 0.1 seconds before continuing
    seconds := seconds - 0.1 %Subtracts 0.1 seconds every 0.1 second
    if seconds < 0 then %Resets second when it goes to 0
	seconds := 59 %Sets new seconds as 59
	intMinutes := intMinutes - 1 %1 minute is subtracted every 60 seconds.
    end if
end timerCounter

%Pauses program for crosswords
procedure pauseProgram
    var key : string (1) %Declares var key as string
    setscreen ("nocursor") %Sets screen so that there is no cursor
    locate (10, 80)
    put "Press any box with a " %Text
    locate (11, 80)
    put "number to get started" %Text
    locate (13, 80)
    put "Press any key to continue..." %Text
    getch (key) %Gets key
    locate (13, 80)
    put "" %Deletes text after key is gotten
    locate (10, 80)
    put "" %Deletes text after key is gotten
    locate (11, 80)
    put "" %Deletes text after key is gotten
end pauseProgram

%Changes between windows
procedure changeWindow
    var key : string (1) %Delcares var key as string
    setscreen ("nocursor") %Sets screen so that there is no cursor
    put "" %Text
    put "Press any key to continue..." %Text
    getch (key) %Gets key before continuing
end changeWindow

%Boxes and graphics for puzzle1
procedure puzzle1Graphics
    %Boxes
    for x : 0 .. 1 %2 letter boxes
	drawbox (540, 580 - 30 * x, 570, 550 - 30 * x, 7)
    end for
    for x : 0 .. 2 %3 letter boxes
	drawbox (330, 490 - 30 * x, 360, 460 - 30 * x, 7) %Boxes
    end for
    for x : 0 .. 3 %4 letter boxes
	drawbox (60, 760 - 30 * x, 90, 730 - 30 * x, 7) %Boxes
	drawbox (210 + 30 * x, 550, 240 + 30 * x, 520, 7) %Boxes
	drawbox (300, 700 - 30 * x, 330, 670 - 30 * x, 7) %Boxes
	drawbox (450, 490 - 30 * x, 480, 460 - 30 * x, 7) %Boxes
    end for
    for x : 0 .. 4 %5 letter boxes
	drawbox (150, 640 - 30 * x, 120, 670 - 30 * x, 7) %Boxes
	drawbox (540, 730 - 30 * x, 570, 760 - 30 * x, 7) %Boxes
    end for
    for x : 0 .. 5 %6 letter boxes
	drawbox (60 + 30 * x, 700, 90 + 30 * x, 670, 7) %Boxes
	drawbox (450 + 30 * x, 670, 480 + 30 * x, 700, 7) %Boxes
	drawbox (480, 730 - 30 * x, 510, 700 - 30 * x, 7) %Boxes
    end for
    for x : 0 .. 6 %7 letter boxes
	drawbox (240, 730 - 30 * x, 210, 700 - 30 * x, 7) %Boxes
	drawbox (210 + 30 * x, 670, 240 + 30 * x, 640, 7) %Boxes
    end for
    for x : 0 .. 7 %8 letter boxes
	drawbox (330 + 30 * x, 580, 360 + 30 * x, 550, 7) %Boxes
    end for
    for x : 0 .. 8 %9 letter boxes
	drawbox (360, 730 - 30 * x, 390, 700 - 30 * x, 7) %Boxes
	drawbox (300 + 30 * x, 490, 330 + 30 * x, 460, 7) %Boxes
    end for
    %Numbers inside of boxes corresponding to hints
    Font.Draw ("1", 62, 750, crosswordFont1, 7) %Number corresponding to hint for word 1
    Font.Draw ("2", 542, 750, crosswordFont1, 7) %Number corresponding to hint for word 2
    Font.Draw ("3", 211, 720, crosswordFont1, 7) %Number corresponding to hint for word 3
    Font.Draw ("4", 362, 720, crosswordFont1, 7) %Number corresponding to hint for word 4
    Font.Draw ("5", 482, 720, crosswordFont1, 7) %Number corresponding to hint for word 5
    Font.Draw ("6", 62, 690, crosswordFont1, 7) %Number corresponding to hint for word 6
    Font.Draw ("7", 122, 690, crosswordFont1, 7) %Number corresponding to hint for word 7
    Font.Draw ("8", 302, 690, crosswordFont1, 7) %Number corresponding to hint for word 8
    Font.Draw ("9", 452, 690, crosswordFont1, 7) %Number corresponding to hint for word 9
    Font.Draw ("10", 211, 660, crosswordFont1, 7) %Number corresponding to hint for word 10
    Font.Draw ("11", 332, 570, crosswordFont1, 7) %Number corresponding to hint for word 11
    Font.Draw ("12", 542, 570, crosswordFont1, 7) %Number corresponding to hint for word 12
    Font.Draw ("13", 212, 540, crosswordFont1, 7) %Number corresponding to hint for word 13
    Font.Draw ("14", 302, 480, crosswordFont1, 7) %Number corresponding to hint for word 14
    Font.Draw ("15", 332, 480, crosswordFont1, 7) %Number corresponding to hint for word 15
    Font.Draw ("16", 452, 480, crosswordFont1, 7) %Number corresponding to hint for word 16
    %Hint text
    locate (26, 1)
    put "Across" ..
    locate (27, 1)
    put "6.  Known for their Ideapad Laptops"
    put "9.  Their name is 'COMPAtibility and Quality' shortened"
    put "10. A South Korean company known for their great phones,"
    put "    such for their galaxy phones as well"
    put "11. This company's CEO is Bracken P. Darell"
    put "13. Known for their Predator gaming laptops"
    put "14. This company is also known for making Windows OS"
    put ""
    put "Down"
    put "1.  Known for their 'Inspiron' laptops"
    put "2.  Jack Naimer's laptop's brand"
    put "3.  This company's CEO is Satoshi Tsunakawa"
    put "4.  Known for their Toughbook laptops "
    put "5.  This company is also known for making Chrome browser"
    put "7.  This company is also known for making amazing"
    put "    graphics cards such as the GeForce GTX 1080 TI"
    put "8.  Known for their ROG gaming laptops"
    put "12. They are also known as Hewlett Packard"
    put "15. This company is known for making the original 'Thinkpad"
    put "    laptops, until Lenovo bought the company"
    put "16. This company's CEO is Kenichiro Yoshida"
end puzzle1Graphics

%Boxes and graphics for puzzle2
procedure puzzle2Graphics
    for x : 0 .. 2 %3 letter boxes
	drawbox (480 + 30 * x, 540, 510 + 30 * x, 570, 7) %Boxes
	drawbox (510 + 30 * x, 390, 540 + 30 * x, 420, 7) %Boxes
	drawbox (30 + 30 * x, 480, 60 + 30 * x, 450, 7) %Boxes
    end for
    for x : 0 .. 4 %5 letter boxes
	drawbox (300 + 30 * x, 540, 330 + 30 * x, 510, 7) %Boxes
    end for
    for x : 0 .. 5 %6 letter boxes
	drawbox (360 + 30 * x, 450, 390 + 30 * x, 480, 7) %Boxes
	drawbox (360 + 30 * x, 330, 390 + 30 * x, 360, 7) %Boxes
	drawbox (360 + 30 * x, 300, 390 + 30 * x, 270, 7) %Boxes
	drawbox (360, 630 - 30 * x, 390, 600 - 30 * x, 7) %Boxes
    end for
    for x : 0 .. 6 %7 letter boxes
	drawbox (30, 660 - 30 * x, 60, 630 - 30 * x, 7) %Boxes
	drawbox (90, 750 - 30 * x, 120, 720 - 30 * x, 7) %Boxes
	drawbox (180, 720 - 30 * x, 210, 690 - 30 * x, 7) %Boxes
	drawbox (180 + 30 * x, 600, 210 + 30 * x, 630, 7) %Boxes
	drawbox (450, 450 - 30 * x, 480, 480 - 30 * x, 7) %Boxes
	drawbox (510, 570 - 30 * x, 540, 600 - 30 * x, 7) %Boxes
	drawbox (30 + 30 * x, 540, 60 + 30 * x, 570, 7) %Boxes
    end for
    for x : 0 .. 7 %8 letter boxes
	drawbox (90 + 30 * x, 660, 120 + 30 * x, 690, 7) %Boxes
    end for
    %Numbers inside boxes corresponding to hints
    Font.Draw ("1", 92, 740, crosswordFont1, 7) %Number corresponding to hint for word 1
    Font.Draw ("2", 182, 710, crosswordFont1, 7) %Number corresponding to hint for word 2
    Font.Draw ("3", 92, 680, crosswordFont1, 7) %Number corresponding to hint for word 3
    Font.Draw ("4", 32, 650, crosswordFont1, 7) %Number corresponding to hint for word 4
    Font.Draw ("5", 182, 620, crosswordFont1, 7) %Number corresponding to hint for word 5
    Font.Draw ("6", 362, 620, crosswordFont1, 7) %Number corresponding to hint for word 6
    Font.Draw ("7", 512, 590, crosswordFont1, 7) %Number corresponding to hint for word 7
    Font.Draw ("8", 32, 560, crosswordFont1, 7) %Number corresponding to hint for word 8
    Font.Draw ("9", 482, 560, crosswordFont1, 7) %Number corresponding to hint for word 9
    Font.Draw ("10", 302, 530, crosswordFont1, 7) %Number corresponding to hint for word 10
    Font.Draw ("11", 32, 470, crosswordFont1, 7) %Number corresponding to hint for word 11
    Font.Draw ("12", 362, 470, crosswordFont1, 7) %Number corresponding to hint for word 12
    Font.Draw ("13", 452, 470, crosswordFont1, 7) %Number corresponding to hint for word 13
    Font.Draw ("14", 512, 410, crosswordFont1, 7) %Number corresponding to hint for word 14
    Font.Draw ("15", 362, 350, crosswordFont1, 7) %Number corresponding to hint for word 15
    Font.Draw ("16", 362, 290, crosswordFont1, 7) %Number corresponding to hint for word 16
    %Hints text
    locate (27, 1)
    put "   Across" ..
    locate (28, 1)
    put "3. One million bytes is equal to a ___" ..
    locate (29, 1)
    put "5. The most used Operating System" ..
    locate (30, 1)
    put "8. WIFI is a wireless ____ (starts with 'n')" ..
    locate (31, 1)
    put "9. ___ loops only run for a limited amount" ..
    locate (32, 1)
    put "of times" ..
    locate (33, 1)
    put "10. The name of the first computer" ..
    locate (34, 1)
    put "11. A computer brand that is also named after a fruit" ..
    locate (35, 1)
    put "12. __ variables can be used throughout the code" ..
    locate (36, 1)
    put "14. A 'permanent' storage device with no moving " ..
    locate (37, 1)
    put "parts" ..
    locate (38, 1)
    put "15. Machine language consists of __ numbers"
    put "16. What does F2 on your keyboard do?"
    put "   Down"
    put "1. An annotation in the source code of a program"
    put "2. Short for MALicious softWARE"
    put "4. This type of computer uses qubits rather than standard machine language"
    put "6. This type of variable stores a sequence of characters"
    put "7. This math function in TURING gives you the remainder"
    put "13. This man originated the concept of a digital programmable computer"
end puzzle2Graphics

%Boxes and graphics for puzzle3
procedure puzzle3Graphics
    for x : 0 .. 2 %3 letter boxes
	drawbox (30, 730 - 30 * x, 60, 760 - 30 * x, 7) %Boxes
	drawbox (90, 730 - 30 * x, 120, 760 - 30 * x, 7) %Boxes
	drawbox (60, 460 - 30 * x, 90, 490 - 30 * x, 7) %Boxes
	drawbox (240 + 30 * x, 520, 270 + 30 * x, 550, 7) %Boxes
	drawbox (420, 490 - 30 * x, 450, 520 - 30 * x, 7) %Boxes
	drawbox (270 + 30 * x, 640, 300 + 30 * x, 670, 7) %Boxes
    end for
    for x : 0 .. 3 %4 letter boxes
	drawbox (120, 550 - 30 * x, 150, 580 - 30 * x, 7) %Boxes
    end for
    for x : 0 .. 4 %5 letter boxes
	drawbox (330, 700 - 30 * x, 360, 730 - 30 * x, 7) %Boxes
    end for
    for x : 0 .. 5 %6 letter boxes
	drawbox (30 + 30 * x, 460, 60 + 30 * x, 490, 7) %Boxes
    end for
    for x : 0 .. 6 %7 letter boxes
	drawbox (30 + 30 * x, 670, 60 + 30 * x, 700, 7) %Boxes
	drawbox (480, 640 - 30 * x, 510, 670 - 30 * x, 7) %Boxes
    end for
    for x : 0 .. 7 %8 letter boxes
	drawbox (390, 730 - 30 * x, 420, 760 - 30 * x, 7) %Boxes
    end for
    for x : 0 .. 8 %9 letter boxes
	drawbox (240 + 30 * x, 460, 270 + 30 * x, 490, 7) %Boxes
    end for
    for x : 0 .. 9 %10 letter boxes
	drawbox (150 + 30 * x, 580, 180 + 30 * x, 610, 7) %Boxes
	drawbox (240, 610 - 30 * x, 270, 640 - 30 * x, 7) %Boxes
    end for
    for x : 0 .. 10 %11 letter boxes
	drawbox (180, 700 - 30 * x, 210, 730 - 30 * x, 7) %Boxes
    end for
    %Numbers in boxes corresponding to hints
    Font.Draw ("1", 32, 750, crosswordFont1, 7) %Number corresponding to hint for word 1
    Font.Draw ("2", 92, 750, crosswordFont1, 7) %Number corresponding to hint for word 2
    Font.Draw ("3", 392, 750, crosswordFont1, 7) %Number corresponding to hint for word 3
    Font.Draw ("4", 182, 720, crosswordFont1, 7) %Number corresponding to hint for word 4
    Font.Draw ("5", 332, 720, crosswordFont1, 7) %Number corresponding to hint for word 5
    Font.Draw ("6", 32, 690, crosswordFont1, 7) %Number corresponding to hint for word 6
    Font.Draw ("7", 272, 660, crosswordFont1, 7) %Number corresponding to hint for word 7
    Font.Draw ("8", 482, 660, crosswordFont1, 7) %Number corresponding to hint for word 8
    Font.Draw ("9", 242, 630, crosswordFont1, 7) %Number corresponding to hint for word 9
    Font.Draw ("10", 152, 600, crosswordFont1, 7) %Number corresponding to hint for word 10
    Font.Draw ("11", 122, 570, crosswordFont1, 7) %Number corresponding to hint for word 11
    Font.Draw ("12", 242, 540, crosswordFont1, 7) %Number corresponding to hint for word 12
    Font.Draw ("13", 422, 510, crosswordFont1, 7) %Number corresponding to hint for word 13
    Font.Draw ("14", 32, 480, crosswordFont1, 7) %Number corresponding to hint for word 14
    Font.Draw ("15", 62, 480, crosswordFont1, 7) %Number corresponding to hint for word 15
    Font.Draw ("16", 242, 480, crosswordFont1, 7) %Number corresponding to hint for word 16
    %Hint text
    locate (26, 5)
    put "Across" ..
    locate (27, 1)
    put "6. The 'screen' of your" ..
    locate (28, 1)
    put "computer" ..
    locate (29, 1)
    put "7. A unit that accelerates the"
    put "creation of images in a frame buffer"
    put "10. An auxiliary device that can be"
    put "used with the computer, eg. a"
    put "mouse, keyboard, or microphone"
    put "12. Storage device that is only used"
    put "to store data being used currently"
    put "14. Used to take videos, or pictures"
    put "16. This is used to PROCESS data"
    put "     Down"
    put "1. Memory that can only be read      11. An enclosure that contains most of "
    put "2. Used to cool down the computer        the components of a computer"
    put "3. Used to input characters into     13. This unit supplies power to the"
    put "the computer                             computer, as well as converting AC"
    put "4. The main circuit board in the         power to low voltage DC power"
    put "computer                             15. Short for Arithemetic Logic Unit"
    put "5. Hand-held pointing device"
    put "8. Outputs audio for your computer"
    put "9. Used to input audio"
end puzzle3Graphics

%Instructions sections
procedure instructions
    var instructionsWin := Window.Open ("graphics:400;400;position:center;center") %Creates new window for instructions
    Window.Hide (mainWin) %Hides main window
    %Texts
    put "How to play:"
    put ""
    put "This puzzle consists of vertical and horizontal"
    put "squares arranged in a certain order so that you"
    put "can type certain words, so that some words will"
    put "use letters from neighbouring words. "
    put ""
    put "Some of these squares contain numbers, which"
    put "corresponds to hints given"
    put ""
    put "Press any numbered box to enter your guess"
    put ""
    put "Your job is to fill the puzzle up with the right"
    put "words. "
    put ""
    put "Have fun!!"
    changeWindow %Waits for user input before closing
    Window.Close (instructionsWin) %Closes window
    Window.Show (mainWin) %Reopens and resumes main window
end instructions

%Activates timer
procedure timed
    timedMode := 1
    randomPuzzleChooser
end timed

procedure mainMenu2
    timedMode := 0 %Resets value for timed mode, in case user chooses to play again
    GUI.Hide (instructionsBtn) %Hides instructionsBtn
    GUI.Hide (playBtn) %Hides playBtn
    title %Refreshes screen
    locate (4, 31)
    put "Would you like to play timed mode or untimed mode?" %Prompt text
    locate (6, 24)
    put "In timed mode, you can set how much time you want to finish by." %Text
    locate (8, 23)
    put "In untimed mode, you have unlimited time to complete the crossword." %Text
    timedBtn := GUI.CreateButton (400, 300, 100, "Timed", timed) %Sets parameters for timedBtn, activates timed mode
    untimedBtn := GUI.CreateButton (400, 250, 100, "Untimed", randomPuzzleChooser) %Sets parameters for untimedBtn, goes directly to randomPuzzleChooser
    GUI.Show (exitBtn)
end mainMenu2


body procedure mainMenu
    titleNum := 1 %Sets titleNum to 1
    title %Clears screen
    GUI.Hide (menuBtn) %Hides menuBtn
    Font.Draw ("Welcome to CROSSWORD! Have Fun!", 250, 500, titleFont, red) %Welcome text
    playBtn := GUI.CreateButton (400, 250, 100, "Play!", mainMenu2) %Sets parameters for playBtn - goes to second main menu
    instructionsBtn := GUI.CreateButton (400, 300, 100, "Instructions", instructions) %Sets parameters for instructionsBtn - opens instructions window
    exitBtn := GUI.CreateButton (400, 200, 100, "Exit", goodbye) %Sets parameters for exitBtn - shows credits, closes game
end mainMenu

procedure endMessage
    crosswordTitle %Refreshes screen, with name of crossword rather than normal title
    GUI.Hide (untimedBtn) %Hides untimedBtn
    GUI.Hide (timedBtn) %Hides timedBtn
    GUI.Hide (exitBtn) %Hides exitBtn
    if endMsgVar = 1 then %End message for when user loses
	menuBtn := GUI.CreateButton (700, 250, 100, "Menu", mainMenu) %Sets parameters for menuBtn - goes back to mainMenu
	if puzzleNum = 1 then %If user loses on puzzle1
	    Font.Draw ("YOU LOSE!", 695, 400, titleFont, black) %Loss text
	    puzzle1Graphics %Shows graphics and boxes for puzzle1
	    %Displays all answers on screen
	    %Answer - Dell
	    Font.Draw ("D", 70, 740, crosswordFont2, black)
	    Font.Draw ("E", 70, 710, crosswordFont2, black)
	    Font.Draw ("L", 70, 680, crosswordFont2, black)
	    Font.Draw ("L", 70, 650, crosswordFont2, black)
	    %Answer - Lenovo
	    Font.Draw ("L", 70, 680, crosswordFont2, black)
	    Font.Draw ("E", 100, 680, crosswordFont2, black)
	    Font.Draw ("N", 130, 680, crosswordFont2, black)
	    Font.Draw ("O", 160, 680, crosswordFont2, black)
	    Font.Draw ("V", 190, 680, crosswordFont2, black)
	    Font.Draw ("O", 220, 680, crosswordFont2, black)
	    %Answer - Nvidia
	    Font.Draw ("N", 130, 680, crosswordFont2, black)
	    Font.Draw ("V", 130, 650, crosswordFont2, black)
	    Font.Draw ("I", 130, 620, crosswordFont2, black)
	    Font.Draw ("D", 130, 590, crosswordFont2, black)
	    Font.Draw ("I", 130, 560, crosswordFont2, black)
	    Font.Draw ("A", 130, 530, crosswordFont2, black)
	    %Answer - Toshiba
	    Font.Draw ("T", 220, 710, crosswordFont2, black)
	    Font.Draw ("O", 220, 680, crosswordFont2, black)
	    Font.Draw ("S", 220, 650, crosswordFont2, black)
	    Font.Draw ("H", 220, 620, crosswordFont2, black)
	    Font.Draw ("I", 220, 590, crosswordFont2, black)
	    Font.Draw ("B", 220, 560, crosswordFont2, black)
	    Font.Draw ("A", 220, 530, crosswordFont2, black)
	    %Answer - Acer
	    Font.Draw ("A", 220, 530, crosswordFont2, black)
	    Font.Draw ("C", 250, 530, crosswordFont2, black)
	    Font.Draw ("E", 280, 530, crosswordFont2, black)
	    Font.Draw ("R", 310, 530, crosswordFont2, black)
	    %Answer - Samsung
	    Font.Draw ("S", 220, 650, crosswordFont2, black)
	    Font.Draw ("A", 250, 650, crosswordFont2, black)
	    Font.Draw ("M", 280, 650, crosswordFont2, black)
	    Font.Draw ("S", 310, 650, crosswordFont2, black)
	    Font.Draw ("U", 340, 650, crosswordFont2, black)
	    Font.Draw ("N", 370, 650, crosswordFont2, black)
	    Font.Draw ("G", 400, 650, crosswordFont2, black)
	    %Answer - Asus
	    Font.Draw ("A", 310, 680, crosswordFont2, black)
	    Font.Draw ("S", 310, 650, crosswordFont2, black)
	    Font.Draw ("U", 310, 620, crosswordFont2, black)
	    Font.Draw ("S", 310, 590, crosswordFont2, black)
	    %Answer - Panasonic
	    Font.Draw ("P", 370, 710, crosswordFont2, black)
	    Font.Draw ("A", 370, 680, crosswordFont2, black)
	    Font.Draw ("N", 370, 650, crosswordFont2, black)
	    Font.Draw ("A", 370, 620, crosswordFont2, black)
	    Font.Draw ("S", 370, 590, crosswordFont2, black)
	    Font.Draw ("O", 370, 560, crosswordFont2, black)
	    Font.Draw ("N", 370, 530, crosswordFont2, black)
	    Font.Draw ("I", 370, 500, crosswordFont2, black)
	    Font.Draw ("C", 370, 468, crosswordFont2, black)
	    %Answer - Logitech
	    Font.Draw ("L", 340, 558, crosswordFont2, black)
	    Font.Draw ("O", 370, 560, crosswordFont2, black)
	    Font.Draw ("G", 400, 560, crosswordFont2, black)
	    Font.Draw ("I", 430, 560, crosswordFont2, black)
	    Font.Draw ("T", 460, 560, crosswordFont2, black)
	    Font.Draw ("E", 490, 560, crosswordFont2, black)
	    Font.Draw ("C", 520, 560, crosswordFont2, black)
	    Font.Draw ("H", 550, 558, crosswordFont2, black)
	    %Answer - HP
	    Font.Draw ("H", 550, 558, crosswordFont2, black)
	    Font.Draw ("P", 550, 530, crosswordFont2, black)
	    %Answer - Microsoft
	    Font.Draw ("M", 310, 468, crosswordFont2, black)
	    Font.Draw ("I", 340, 468, crosswordFont2, black)
	    Font.Draw ("C", 370, 468, crosswordFont2, black)
	    Font.Draw ("R", 400, 468, crosswordFont2, black)
	    Font.Draw ("O", 430, 468, crosswordFont2, black)
	    Font.Draw ("S", 460, 468, crosswordFont2, black)
	    Font.Draw ("O", 490, 468, crosswordFont2, black)
	    Font.Draw ("F", 520, 468, crosswordFont2, black)
	    Font.Draw ("T", 550, 468, crosswordFont2, black)
	    %Answer - IBM
	    Font.Draw ("I", 340, 468, crosswordFont2, black)
	    Font.Draw ("B", 340, 440, crosswordFont2, black)
	    Font.Draw ("M", 340, 410, crosswordFont2, black)
	    %Answer - Sony
	    Font.Draw ("S", 460, 468, crosswordFont2, black)
	    Font.Draw ("O", 460, 440, crosswordFont2, black)
	    Font.Draw ("N", 460, 410, crosswordFont2, black)
	    Font.Draw ("Y", 460, 380, crosswordFont2, black)
	    %Answer - Google
	    Font.Draw ("G", 490, 710, crosswordFont2, black)
	    Font.Draw ("O", 490, 680, crosswordFont2, black)
	    Font.Draw ("O", 490, 650, crosswordFont2, black)
	    Font.Draw ("G", 490, 620, crosswordFont2, black)
	    Font.Draw ("L", 490, 590, crosswordFont2, black)
	    Font.Draw ("E", 490, 560, crosswordFont2, black)
	    %Answer - COMPAQ
	    Font.Draw ("C", 460, 680, crosswordFont2, black)
	    Font.Draw ("O", 490, 680, crosswordFont2, black)
	    Font.Draw ("M", 520, 680, crosswordFont2, black)
	    Font.Draw ("P", 550, 680, crosswordFont2, black)
	    Font.Draw ("A", 580, 680, crosswordFont2, black)
	    Font.Draw ("Q", 610, 680, crosswordFont2, black)
	    %Answer - Apple
	    Font.Draw ("A", 550, 740, crosswordFont2, black)
	    Font.Draw ("P", 550, 710, crosswordFont2, black)
	    Font.Draw ("P", 550, 680, crosswordFont2, black)
	    Font.Draw ("L", 550, 650, crosswordFont2, black)
	    Font.Draw ("E", 550, 620, crosswordFont2, black)
	    GUI.Show (menuBtn) %Shows menuBtn - allows user to go back to mainMenu
	end if
	if puzzleNum = 2 then %If user loses on puzzle2
	    puzzle2Graphics %Shows graphics and boxes for puzzle2
	    Font.Draw ("YOU LOSE!", 695, 400, titleFont, black) %Loss message
	    %Answer - Quantum
	    Font.Draw ("Q", 40, 640, crosswordFont2, black)
	    Font.Draw ("U", 40, 610, crosswordFont2, black)
	    Font.Draw ("A", 40, 580, crosswordFont2, black)
	    Font.Draw ("N", 40, 550, crosswordFont2, black)
	    Font.Draw ("T", 40, 520, crosswordFont2, black)
	    Font.Draw ("U", 40, 490, crosswordFont2, black)
	    Font.Draw ("M", 40, 458, crosswordFont2, black)
	    %Answer - Mac
	    Font.Draw ("M", 40, 458, crosswordFont2, black)
	    Font.Draw ("A", 70, 458, crosswordFont2, black)
	    Font.Draw ("C", 100, 458, crosswordFont2, black)
	    %Answer - Network
	    Font.Draw ("N", 40, 550, crosswordFont2, black)
	    Font.Draw ("E", 70, 550, crosswordFont2, black)
	    Font.Draw ("T", 100, 550, crosswordFont2, black)
	    Font.Draw ("W", 130, 550, crosswordFont2, black)
	    Font.Draw ("O", 160, 550, crosswordFont2, black)
	    Font.Draw ("R", 190, 550, crosswordFont2, black)
	    Font.Draw ("K", 220, 550, crosswordFont2, black)
	    %Answer - Comment
	    Font.Draw ("C", 100, 730, crosswordFont2, black)
	    Font.Draw ("O", 100, 700, crosswordFont2, black)
	    Font.Draw ("M", 100, 670, crosswordFont2, black)
	    Font.Draw ("M", 100, 640, crosswordFont2, black)
	    Font.Draw ("E", 100, 610, crosswordFont2, black)
	    Font.Draw ("N", 100, 580, crosswordFont2, black)
	    Font.Draw ("T", 100, 550, crosswordFont2, black)
	    %Answer - Megabyte
	    Font.Draw ("M", 100, 670, crosswordFont2, black)
	    Font.Draw ("E", 130, 670, crosswordFont2, black)
	    Font.Draw ("G", 160, 670, crosswordFont2, black)
	    Font.Draw ("A", 190, 670, crosswordFont2, black)
	    Font.Draw ("B", 220, 670, crosswordFont2, black)
	    Font.Draw ("Y", 250, 670, crosswordFont2, black)
	    Font.Draw ("T", 280, 670, crosswordFont2, black)
	    Font.Draw ("E", 310, 670, crosswordFont2, black)
	    %Answer - Malware
	    Font.Draw ("M", 190, 700, crosswordFont2, black)
	    Font.Draw ("A", 190, 670, crosswordFont2, black)
	    Font.Draw ("L", 190, 640, crosswordFont2, black)
	    Font.Draw ("W", 190, 610, crosswordFont2, black)
	    Font.Draw ("A", 190, 580, crosswordFont2, black)
	    Font.Draw ("R", 190, 550, crosswordFont2, black)
	    Font.Draw ("E", 190, 520, crosswordFont2, black)
	    %Answer - Windows
	    Font.Draw ("W", 190, 610, crosswordFont2, black)
	    Font.Draw ("I", 220, 610, crosswordFont2, black)
	    Font.Draw ("N", 250, 610, crosswordFont2, black)
	    Font.Draw ("D", 280, 610, crosswordFont2, black)
	    Font.Draw ("O", 310, 610, crosswordFont2, black)
	    Font.Draw ("W", 340, 610, crosswordFont2, black)
	    Font.Draw ("S", 370, 610, crosswordFont2, black)
	    %Answer - String
	    Font.Draw ("S", 370, 610, crosswordFont2, black)
	    Font.Draw ("T", 370, 580, crosswordFont2, black)
	    Font.Draw ("R", 370, 550, crosswordFont2, black)
	    Font.Draw ("I", 370, 518, crosswordFont2, black)
	    Font.Draw ("N", 370, 490, crosswordFont2, black)
	    Font.Draw ("G", 370, 458, crosswordFont2, black)
	    %Answer - Eniac
	    Font.Draw ("E", 310, 518, crosswordFont2, black)
	    Font.Draw ("N", 340, 518, crosswordFont2, black)
	    Font.Draw ("I", 370, 518, crosswordFont2, black)
	    Font.Draw ("A", 400, 518, crosswordFont2, black)
	    Font.Draw ("C", 430, 518, crosswordFont2, black)
	    %Answer - Global
	    Font.Draw ("G", 370, 458, crosswordFont2, black)
	    Font.Draw ("L", 400, 458, crosswordFont2, black)
	    Font.Draw ("O", 430, 458, crosswordFont2, black)
	    Font.Draw ("B", 460, 458, crosswordFont2, black)
	    Font.Draw ("A", 490, 458, crosswordFont2, black)
	    Font.Draw ("L", 520, 458, crosswordFont2, black)
	    %Answer - Babbage
	    Font.Draw ("B", 460, 458, crosswordFont2, black)
	    Font.Draw ("A", 460, 430, crosswordFont2, black)
	    Font.Draw ("B", 460, 400, crosswordFont2, black)
	    Font.Draw ("B", 460, 370, crosswordFont2, black)
	    Font.Draw ("A", 460, 338, crosswordFont2, black)
	    Font.Draw ("G", 460, 310, crosswordFont2, black)
	    Font.Draw ("E", 460, 278, crosswordFont2, black)
	    %Answer - Binary
	    Font.Draw ("B", 370, 338, crosswordFont2, black)
	    Font.Draw ("I", 400, 338, crosswordFont2, black)
	    Font.Draw ("N", 430, 338, crosswordFont2, black)
	    Font.Draw ("A", 460, 338, crosswordFont2, black)
	    Font.Draw ("R", 490, 338, crosswordFont2, black)
	    Font.Draw ("Y", 520, 338, crosswordFont2, black)
	    %Answer - Indent
	    Font.Draw ("I", 370, 278, crosswordFont2, black)
	    Font.Draw ("N", 400, 278, crosswordFont2, black)
	    Font.Draw ("D", 430, 278, crosswordFont2, black)
	    Font.Draw ("E", 460, 278, crosswordFont2, black)
	    Font.Draw ("N", 490, 278, crosswordFont2, black)
	    Font.Draw ("T", 520, 278, crosswordFont2, black)
	    %Answer - Modulus
	    Font.Draw ("M", 520, 580, crosswordFont2, black)
	    Font.Draw ("O", 520, 550, crosswordFont2, black)
	    Font.Draw ("D", 520, 520, crosswordFont2, black)
	    Font.Draw ("U", 520, 490, crosswordFont2, black)
	    Font.Draw ("L", 520, 458, crosswordFont2, black)
	    Font.Draw ("U", 520, 430, crosswordFont2, black)
	    Font.Draw ("S", 520, 398, crosswordFont2, black)
	    %Answer - SSD
	    Font.Draw ("S", 520, 398, crosswordFont2, black)
	    Font.Draw ("S", 550, 398, crosswordFont2, black)
	    Font.Draw ("D", 580, 398, crosswordFont2, black)
	    %Answer - For
	    Font.Draw ("F", 490, 550, crosswordFont2, black)
	    Font.Draw ("O", 520, 550, crosswordFont2, black)
	    Font.Draw ("R", 550, 550, crosswordFont2, black)
	    GUI.Show (menuBtn) %Shows menuBtn - allows user to return to mainMenu
	end if
	if puzzleNum = 3 then %If user loses on puzzle3
	    puzzle3Graphics %Shows graphics and boxes for puzzle3
	    Font.Draw ("YOU LOSE!", 695, 400, titleFont, black) %Loss message
	    %Answer - ROM
	    Font.Draw ("R", 40, 740, crosswordFont2, black)
	    Font.Draw ("O", 40, 710, crosswordFont2, black)
	    Font.Draw ("M", 40, 680, crosswordFont2, black)
	    %Answer - Monitor
	    Font.Draw ("M", 40, 680, crosswordFont2, black)
	    Font.Draw ("O", 70, 680, crosswordFont2, black)
	    Font.Draw ("N", 100, 680, crosswordFont2, black)
	    Font.Draw ("I", 130, 680, crosswordFont2, black)
	    Font.Draw ("T", 160, 680, crosswordFont2, black)
	    Font.Draw ("O", 190, 680, crosswordFont2, black)
	    Font.Draw ("R", 220, 680, crosswordFont2, black)
	    %Answer - Fan
	    Font.Draw ("F", 100, 740, crosswordFont2, black)
	    Font.Draw ("A", 100, 710, crosswordFont2, black)
	    Font.Draw ("N", 100, 680, crosswordFont2, black)
	    %Answer - Motherboard
	    Font.Draw ("M", 190, 710, crosswordFont2, black)
	    Font.Draw ("O", 190, 680, crosswordFont2, black)
	    Font.Draw ("T", 190, 650, crosswordFont2, black)
	    Font.Draw ("H", 190, 620, crosswordFont2, black)
	    Font.Draw ("E", 190, 590, crosswordFont2, black)
	    Font.Draw ("R", 190, 560, crosswordFont2, black)
	    Font.Draw ("B", 190, 530, crosswordFont2, black)
	    Font.Draw ("O", 190, 500, crosswordFont2, black)
	    Font.Draw ("A", 190, 470, crosswordFont2, black)
	    Font.Draw ("R", 190, 440, crosswordFont2, black)
	    Font.Draw ("D", 190, 410, crosswordFont2, black)
	    %Answer - Peripheral
	    Font.Draw ("P", 162, 590, crosswordFont2, black)
	    Font.Draw ("E", 190, 590, crosswordFont2, black)
	    Font.Draw ("R", 220, 590, crosswordFont2, black)
	    Font.Draw ("I", 252, 590, crosswordFont2, black)
	    Font.Draw ("P", 280, 590, crosswordFont2, black)
	    Font.Draw ("H", 310, 590, crosswordFont2, black)
	    Font.Draw ("E", 340, 590, crosswordFont2, black)
	    Font.Draw ("R", 370, 590, crosswordFont2, black)
	    Font.Draw ("A", 400, 590, crosswordFont2, black)
	    Font.Draw ("L", 430, 590, crosswordFont2, black)
	    %Answer - Camera
	    Font.Draw ("C", 42, 470, crosswordFont2, black)
	    Font.Draw ("A", 72, 470, crosswordFont2, black)
	    Font.Draw ("M", 100, 470, crosswordFont2, black)
	    Font.Draw ("E", 130, 470, crosswordFont2, black)
	    Font.Draw ("R", 160, 470, crosswordFont2, black)
	    Font.Draw ("A", 190, 470, crosswordFont2, black)
	    %Answer - ALU
	    Font.Draw ("A", 72, 470, crosswordFont2, black)
	    Font.Draw ("L", 72, 440, crosswordFont2, black)
	    Font.Draw ("U", 72, 410, crosswordFont2, black)
	    %Answer - Case
	    Font.Draw ("C", 130, 560, crosswordFont2, black)
	    Font.Draw ("A", 130, 530, crosswordFont2, black)
	    Font.Draw ("S", 130, 500, crosswordFont2, black)
	    Font.Draw ("E", 130, 470, crosswordFont2, black)
	    %Answer - Microphone
	    Font.Draw ("M", 252, 620, crosswordFont2, black)
	    Font.Draw ("I", 252, 590, crosswordFont2, black)
	    Font.Draw ("C", 252, 560, crosswordFont2, black)
	    Font.Draw ("R", 252, 530, crosswordFont2, black)
	    Font.Draw ("O", 252, 500, crosswordFont2, black)
	    Font.Draw ("P", 252, 470, crosswordFont2, black)
	    Font.Draw ("H", 252, 440, crosswordFont2, black)
	    Font.Draw ("O", 252, 410, crosswordFont2, black)
	    Font.Draw ("N", 252, 380, crosswordFont2, black)
	    Font.Draw ("E", 252, 350, crosswordFont2, black)
	    %Answer - Mouse
	    Font.Draw ("M", 340, 710, crosswordFont2, black)
	    Font.Draw ("O", 340, 680, crosswordFont2, black)
	    Font.Draw ("U", 340, 650, crosswordFont2, black)
	    Font.Draw ("S", 340, 620, crosswordFont2, black)
	    Font.Draw ("E", 340, 590, crosswordFont2, black)
	    %Answer - Keyboard
	    Font.Draw ("K", 400, 740, crosswordFont2, black)
	    Font.Draw ("E", 400, 710, crosswordFont2, black)
	    Font.Draw ("Y", 400, 680, crosswordFont2, black)
	    Font.Draw ("B", 400, 650, crosswordFont2, black)
	    Font.Draw ("O", 400, 620, crosswordFont2, black)
	    Font.Draw ("A", 400, 590, crosswordFont2, black)
	    Font.Draw ("R", 400, 560, crosswordFont2, black)
	    Font.Draw ("D", 400, 530, crosswordFont2, black)
	    %Answer - GPU
	    Font.Draw ("G", 280, 650, crosswordFont2, black)
	    Font.Draw ("P", 310, 650, crosswordFont2, black)
	    Font.Draw ("U", 340, 650, crosswordFont2, black)
	    %Answer - RAM
	    Font.Draw ("R", 252, 530, crosswordFont2, black)
	    Font.Draw ("A", 280, 530, crosswordFont2, black)
	    Font.Draw ("M", 310, 530, crosswordFont2, black)
	    %Answer - Processor
	    Font.Draw ("P", 252, 470, crosswordFont2, black)
	    Font.Draw ("R", 282, 470, crosswordFont2, black)
	    Font.Draw ("O", 312, 470, crosswordFont2, black)
	    Font.Draw ("C", 342, 470, crosswordFont2, black)
	    Font.Draw ("E", 372, 470, crosswordFont2, black)
	    Font.Draw ("S", 402, 470, crosswordFont2, black)
	    Font.Draw ("S", 432, 470, crosswordFont2, black)
	    Font.Draw ("O", 462, 470, crosswordFont2, black)
	    Font.Draw ("R", 492, 470, crosswordFont2, black)
	    %Answer - PSU
	    Font.Draw ("P", 432, 500, crosswordFont2, black)
	    Font.Draw ("S", 432, 470, crosswordFont2, black)
	    Font.Draw ("U", 432, 440, crosswordFont2, black)
	    %Answer - Speaker
	    Font.Draw ("S", 492, 650, crosswordFont2, black)
	    Font.Draw ("P", 492, 620, crosswordFont2, black)
	    Font.Draw ("E", 492, 590, crosswordFont2, black)
	    Font.Draw ("A", 492, 560, crosswordFont2, black)
	    Font.Draw ("K", 492, 530, crosswordFont2, black)
	    Font.Draw ("E", 492, 500, crosswordFont2, black)
	    Font.Draw ("R", 492, 470, crosswordFont2, black)
	    GUI.Show (menuBtn) %Shows menuBtn - allows user to return to mainMenu
	end if
	%If user wins the puzzle
    elsif endMsgVar = 2 then
	GUI.SetBackgroundColor (11) %Sets background color to 11
	Font.Draw ("You Win!", 400, 400, titleFont, black) %Win message
	menuBtn := GUI.CreateButton (400, 250, 100, "Menu", mainMenu) %Sets parameters for menuBtn - allows user to return to mainMenu
    end if
end endMessage

%Gets guess from user in crossword
procedure userInput
    var userInputWin := Window.Open ("graphics:400;400;position:top;right") %Creates new window for user input
    titleNum := 2 %Sets titleNum to 2 - for userInput sections
    loop
	title %Refreshes screen
	put "Please input your guess.." %Prompt text
	get guess %Gets guess
	%Error trap
	if length (guess) not= length (answer) then %If guess is longer or shorter than the answer
	    locate (5, 1)
	    put "Your guess needs to be ", length (answer), " characters long!" %Tells user how long their guess should be
	    delay (1000) %Waits for 1 second before resuming loop
	end if
	exit when length (guess) = length (answer) %Exits loop when users guess is as long as the answer
    end loop
    Window.Close (userInputWin) %Closes userInputWin
end userInput

%Procedure for when users guess is wrong
procedure wrongAnswer
    locate (10, 100)
    put "WRONG" %Text
    delay (1000) %Delays 1 second
    locate (10, 100)
    put "" %Erases text
end wrongAnswer
procedure correctAnswer
    locate (10, 100)
    put "Correct!" %Text
    delay (1000) %Delays 1 second
    locate (10, 100)
    put "" %Erases text
end correctAnswer

%Puzzle1 - display and processing
procedure puzzle1
    crosswordTitle %Refreshes screen with correct title
    puzzle1Graphics %Loads in boxes and graphics
    pauseProgram %Pauses program - tells user how to play, in case they did not read instructions
    %Timer, if user selects so
    if timedMode = 1 then %If timedMode is activated
	timerUserInput %Gets the amount of time
    end if
    drawbox (725, 225, 575, 125, 7) %Draws box for give up
    Font.Draw ("Give up?", 602, 167, titleFont, 7) %Give up text
    %Loop - timer and mousewhere
    loop
	if timedMode = 1 then %If timer is activated
	    timerCounter %Counts time
	    if intMinutes < 0 then %Exit when timer reaches 0
		endMsgVar := 1 %Sets endMsgVar to 1 - Loss
		exit %Exits loop
	    end if
	end if
	%Mousewhere and userInput
	mousewhere (mouseX, mouseY, button)
	if mouseX > 60 and mouseX < 90 and mouseY > 730 and mouseY < 760 and button = 1 then %If user clicks on Dell box
	    answer := "dell" %Sets correct answer
	    userInput %Gets guess
	    if Str.Lower (guess) = answer then %If guess is correct
		correctAnswer %Correct text
		%Inputs DELL into boxes
		Font.Draw ("D", 70, 740, crosswordFont2, black)
		Font.Draw ("E", 70, 710, crosswordFont2, black)
		Font.Draw ("L", 70, 680, crosswordFont2, black)
		Font.Draw ("L", 70, 650, crosswordFont2, black)
		winChecker (1) := 1 %Assigns winChecker(1) a value of 1
	    else %If guess is wrong
		wrongAnswer %Wrong text
	    end if
	end if
	if mouseX > 60 and mouseX < 90 and mouseY > 670 and mouseY < 700 and button = 1 then %If user clicks on Lenovo box
	    answer := "lenovo" %Sets correct answer
	    userInput %Gets guess
	    if Str.Lower (guess) = answer then %If guess is correct
		correctAnswer %Correct text
		%Inputs LENOVO into boxes
		Font.Draw ("L", 70, 680, crosswordFont2, black)
		Font.Draw ("E", 100, 680, crosswordFont2, black)
		Font.Draw ("N", 130, 680, crosswordFont2, black)
		Font.Draw ("O", 160, 680, crosswordFont2, black)
		Font.Draw ("V", 190, 680, crosswordFont2, black)
		Font.Draw ("O", 220, 680, crosswordFont2, black)
		winChecker (2) := 1 %Assigns winChecker(2) a value of 1
	    else %If guess is wrong
		wrongAnswer %Wrong text
	    end if
	end if
	if mouseX > 120 and mouseX < 150 and mouseY > 670 and mouseY < 700 and button = 1 then %If user clicks on Nvidia box
	    answer := "nvidia" %Sets correct answer
	    userInput %Gets guess
	    if Str.Lower (guess) = answer then %If answer is correct
		correctAnswer %Correct text
		%Inputs NVIDIA into boxes
		Font.Draw ("N", 130, 680, crosswordFont2, black)
		Font.Draw ("V", 130, 650, crosswordFont2, black)
		Font.Draw ("I", 130, 620, crosswordFont2, black)
		Font.Draw ("D", 130, 590, crosswordFont2, black)
		Font.Draw ("I", 130, 560, crosswordFont2, black)
		Font.Draw ("A", 130, 530, crosswordFont2, black)
		winChecker (3) := 1 %Assigns winChecker(3) a value of 1
	    else %If guess is wrong
		wrongAnswer %Wrong text
	    end if
	end if
	if mouseX > 210 and mouseX < 240 and mouseY > 700 and mouseY < 730 and button = 1 then %If user clicks on Toshiba box
	    answer := "toshiba" %Sets correct answer
	    userInput %Gets guess
	    if Str.Lower (guess) = answer then %If guess is correct
		correctAnswer %Correct text
		%Inputs TOSHIBA into boxes
		Font.Draw ("T", 220, 710, crosswordFont2, black)
		Font.Draw ("O", 220, 680, crosswordFont2, black)
		Font.Draw ("S", 220, 650, crosswordFont2, black)
		Font.Draw ("H", 220, 620, crosswordFont2, black)
		Font.Draw ("I", 220, 590, crosswordFont2, black)
		Font.Draw ("B", 220, 560, crosswordFont2, black)
		Font.Draw ("A", 220, 530, crosswordFont2, black)
		winChecker (4) := 1 %Assigns winChecker(4) a value of 1
	    else %If guess is wrong
		wrongAnswer %Wrong text
	    end if
	end if
	if mouseX > 210 and mouseX < 240 and mouseY > 520 and mouseY < 550 and button = 1 then %If user clicks on Acer boxes
	    answer := "acer" %Sets correct answer
	    userInput %Gets guess
	    if Str.Lower (guess) = answer then %If guess is correct
		correctAnswer %Correct text
		%Inputs ACER into boxes
		Font.Draw ("A", 220, 530, crosswordFont2, black)
		Font.Draw ("C", 250, 530, crosswordFont2, black)
		Font.Draw ("E", 280, 530, crosswordFont2, black)
		Font.Draw ("R", 310, 530, crosswordFont2, black)
		winChecker (5) := 1 %Assigns winChecker(5) a value of 1
	    else %If guess is wrong
		wrongAnswer %Wrong text
	    end if
	end if
	if mouseX > 210 and mouseX < 240 and mouseY > 640 and mouseY < 670 and button = 1 then %If user clicks on Samsung box
	    answer := "samsung" %Sets correct answer
	    userInput %Gets guess
	    if Str.Lower (guess) = answer then %If guess is correct
		correctAnswer %Correct text
		%Inputs SAMSUNG into boxes
		Font.Draw ("S", 220, 650, crosswordFont2, black)
		Font.Draw ("A", 250, 650, crosswordFont2, black)
		Font.Draw ("M", 280, 650, crosswordFont2, black)
		Font.Draw ("S", 310, 650, crosswordFont2, black)
		Font.Draw ("U", 340, 650, crosswordFont2, black)
		Font.Draw ("N", 370, 650, crosswordFont2, black)
		Font.Draw ("G", 400, 650, crosswordFont2, black)
		winChecker (6) := 1 %Assigns winChecker(6) a value of 1
	    else %If guess is wrong
		wrongAnswer %Wrong text
	    end if
	end if
	if mouseX > 300 and mouseX < 330 and mouseY > 670 and mouseY < 700 and button = 1 then %If user clicks on Asus box
	    answer := "asus" %Sets correct answer
	    userInput %Gets guess
	    if Str.Lower (guess) = answer then %If guess is correct
		correctAnswer %Correct text
		%Inputs ASUS into boxes
		Font.Draw ("A", 310, 680, crosswordFont2, black)
		Font.Draw ("S", 310, 650, crosswordFont2, black)
		Font.Draw ("U", 310, 620, crosswordFont2, black)
		Font.Draw ("S", 310, 590, crosswordFont2, black)
		winChecker (7) := 1 %Assigns winChecker(7) a value of 1
	    else %If guess is wrong
		wrongAnswer %Wrong text
	    end if
	end if
	if mouseX > 360 and mouseX < 390 and mouseY > 700 and mouseY < 730 and button = 1 then %If user clicks on Panasonic text
	    answer := "panasonic" %Sets correct answer
	    userInput %Gets guess
	    if Str.Lower (guess) = answer then %If guess is correct
		correctAnswer %Correct text
		%Inputs PANASONIC into boxes
		Font.Draw ("P", 370, 710, crosswordFont2, black)
		Font.Draw ("A", 370, 680, crosswordFont2, black)
		Font.Draw ("N", 370, 650, crosswordFont2, black)
		Font.Draw ("A", 370, 620, crosswordFont2, black)
		Font.Draw ("S", 370, 590, crosswordFont2, black)
		Font.Draw ("O", 370, 560, crosswordFont2, black)
		Font.Draw ("N", 370, 530, crosswordFont2, black)
		Font.Draw ("I", 370, 500, crosswordFont2, black)
		Font.Draw ("C", 370, 468, crosswordFont2, black)
		winChecker (8) := 1 %Assigns winChecker(8) a value of 1
	    else %If guess is wrong
		wrongAnswer %Wrong text
	    end if
	end if
	if mouseX > 330 and mouseX < 360 and mouseY > 550 and mouseY < 580 and button = 1 then %If user clicks on Logitech box
	    answer := "logitech" %Sets correct answer
	    userInput %Gets guess
	    if Str.Lower (guess) = answer then %If guess is correct
		correctAnswer %Correct text
		%Inputs LOGITECH into boxes
		Font.Draw ("L", 340, 558, crosswordFont2, black)
		Font.Draw ("O", 370, 560, crosswordFont2, black)
		Font.Draw ("G", 400, 560, crosswordFont2, black)
		Font.Draw ("I", 430, 560, crosswordFont2, black)
		Font.Draw ("T", 460, 560, crosswordFont2, black)
		Font.Draw ("E", 490, 560, crosswordFont2, black)
		Font.Draw ("C", 520, 560, crosswordFont2, black)
		Font.Draw ("H", 550, 558, crosswordFont2, black)
		winChecker (9) := 1 %Assigns winChecker(9) a value of 1
	    else %If user is wrong
		wrongAnswer %Wrong text
	    end if
	end if
	if mouseX > 540 and mouseX < 570 and mouseY > 550 and mouseY < 580 and button = 1 then %If user clicks on HP box
	    answer := "hp" %Sets correct answer
	    userInput %Gets guess
	    if Str.Lower (guess) = answer then %If guess is correct
		correctAnswer %Correct text
		%Inputs HP into boxes
		Font.Draw ("H", 550, 558, crosswordFont2, black)
		Font.Draw ("P", 550, 530, crosswordFont2, black)
		winChecker (10) := 1 %Assigns winChecker(10) a value of 1
	    else %If guess is wrong
		wrongAnswer %Wrong text
	    end if
	end if
	if mouseX > 300 and mouseX < 330 and mouseY > 460 and mouseY < 490 and button = 1 then %If user clicks on Microsoft box
	    answer := "microsoft" %Sets correct answer
	    userInput %Gets guess
	    if Str.Lower (guess) = answer then %If guess is correct
		correctAnswer %Correct text
		%Inputs MICROSOFT into boxes
		Font.Draw ("M", 310, 468, crosswordFont2, black)
		Font.Draw ("I", 340, 468, crosswordFont2, black)
		Font.Draw ("C", 370, 468, crosswordFont2, black)
		Font.Draw ("R", 400, 468, crosswordFont2, black)
		Font.Draw ("O", 430, 468, crosswordFont2, black)
		Font.Draw ("S", 460, 468, crosswordFont2, black)
		Font.Draw ("O", 490, 468, crosswordFont2, black)
		Font.Draw ("F", 520, 468, crosswordFont2, black)
		Font.Draw ("T", 550, 468, crosswordFont2, black)
		winChecker (11) := 1 %Assigns winChecker(11) a value of 1
	    else %If guess is wrong
		wrongAnswer %Wrong text
	    end if
	end if
	if mouseX > 330 and mouseX < 360 and mouseY > 460 and mouseY < 490 and button = 1 then %If user clicks on IBM box
	    answer := "ibm" %Sets correct answer
	    userInput %Gets guess
	    if Str.Lower (guess) = answer then %If guess is correct
		correctAnswer %Correct text
		%Inputs IBM into boxes
		Font.Draw ("I", 340, 468, crosswordFont2, black)
		Font.Draw ("B", 340, 440, crosswordFont2, black)
		Font.Draw ("M", 340, 410, crosswordFont2, black)
		winChecker (12) := 1 %Assigns winChecker(12) a value of 1
	    else %If guess is wrong
		wrongAnswer %Wrong text
	    end if
	end if
	if mouseX > 450 and mouseX < 480 and mouseY > 460 and mouseY < 490 and button = 1 then %If user clicks on Sony box
	    answer := "sony" %Sets correct answer
	    userInput %Gets guess
	    if Str.Lower (guess) = answer then %If guess is correct
		correctAnswer %Correct text
		%Inputs SONY into boxes
		Font.Draw ("S", 460, 468, crosswordFont2, black)
		Font.Draw ("O", 460, 440, crosswordFont2, black)
		Font.Draw ("N", 460, 410, crosswordFont2, black)
		Font.Draw ("Y", 460, 380, crosswordFont2, black)
		winChecker (13) := 1 %Assigns winChecker(13) a value of 1
	    else %If guess is wrong
		wrongAnswer %Wrong text
	    end if
	end if
	if mouseX > 480 and mouseX < 510 and mouseY > 700 and mouseY < 730 and button = 1 then %If user clicks on Google box
	    answer := "google" %Sets correct answer
	    userInput %Gets guess
	    if Str.Lower (guess) = answer then %If guess is correct
		correctAnswer %Correct text
		%Inputs GOOGLE into boxes
		Font.Draw ("G", 490, 710, crosswordFont2, black)
		Font.Draw ("O", 490, 680, crosswordFont2, black)
		Font.Draw ("O", 490, 650, crosswordFont2, black)
		Font.Draw ("G", 490, 620, crosswordFont2, black)
		Font.Draw ("L", 490, 590, crosswordFont2, black)
		Font.Draw ("E", 490, 560, crosswordFont2, black)
		winChecker (14) := 1 %Assigns winChecker(14) a value of 1
	    else %If guess is wrong
		wrongAnswer %Wrong text
	    end if
	end if
	if mouseX > 450 and mouseX < 480 and mouseY > 670 and mouseY < 700 and button = 1 then %If user clicks on COMPAQ box
	    answer := "compaq" %Sets correct answer
	    userInput %Gets guess
	    if Str.Lower (guess) = answer then %If guess is correct
		correctAnswer %Correct text
		%Inputs COMPAQ into boxes
		Font.Draw ("C", 460, 680, crosswordFont2, black)
		Font.Draw ("O", 490, 680, crosswordFont2, black)
		Font.Draw ("M", 520, 680, crosswordFont2, black)
		Font.Draw ("P", 550, 680, crosswordFont2, black)
		Font.Draw ("A", 580, 680, crosswordFont2, black)
		Font.Draw ("Q", 610, 680, crosswordFont2, black)
		winChecker (15) := 1 %Assigns winChecker(15) a value of 1
	    else %If guess is wrong
		wrongAnswer %Wrong text
	    end if
	end if
	if mouseX > 540 and mouseX < 570 and mouseY > 730 and mouseY < 760 and button = 1 then %If user clicks on Apple box
	    answer := "apple" %Sets correct answer
	    userInput %Gets guess
	    if Str.Lower (guess) = answer then %If guess is correct
		correctAnswer %Correct text
		%Inputs APPLE into boxes
		Font.Draw ("A", 550, 740, crosswordFont2, black)
		Font.Draw ("P", 550, 710, crosswordFont2, black)
		Font.Draw ("P", 550, 680, crosswordFont2, black)
		Font.Draw ("L", 550, 650, crosswordFont2, black)
		Font.Draw ("E", 550, 620, crosswordFont2, black)
		winChecker (16) := 1 %Assigns winChecker(16) a value of 1
	    else %If guess is wrong
		wrongAnswer %Wrong text
	    end if
	end if
	%Checks if all crosswords have been completed
	if winChecker (1) + winChecker (2) + winChecker (3) + winChecker (4) + winChecker (5) + winChecker (6) + winChecker (7) + winChecker (8) +
		winChecker (9) + winChecker (10) + winChecker (11) + winChecker (12) + winChecker (13) + winChecker (14) + winChecker (15) + winChecker (16) = 16 then
	    endMsgVar := 2 %If all crosswords have been completed, sets endMsgVar to 2 - Win
	    exit %Exits loop
	end if
	%If user presses Give up box
	if mouseX > 575 and mouseX < 725 and mouseY > 125 and mouseY < 225 and button = 1 then
	    endMsgVar := 1 %Sets endMsgVar to 1 - Loss
	    exit %Exits loop
	end if
    end loop
    endMessage %Goes to endMessage
end puzzle1

%Puzzle2 - display and processing
procedure puzzle2
    crosswordTitle %Refreshes screen, with correct title
    puzzle2Graphics %Loads boxes and graphics
    pauseProgram %Pauses program - tells user how to play, in case they did not read instructions
    %Timer, if user selects so
    if timedMode = 1 then
	timerUserInput %Gets minutes
    end if
    %Give up box
    drawbox (725, 225, 575, 125, 7) %Box
    Font.Draw ("Give up?", 602, 167, titleFont, 7) %Text
    %Loop - mousewhere and timer
    loop
	%Timer
	if timedMode = 1 then %If user activates timer
	    timerCounter %Counts time
	    if intMinutes < 0 then %If time runs out
		endMsgVar := 1 %Sets endMsgVar to 1 - Loss
		exit %Exits loop
	    end if
	end if
	%Mousewhere and userInput
	mousewhere (mouseX, mouseY, button)
	if mouseX > 30 and mouseX < 60 and mouseY > 630 and mouseY < 660 and button = 1 then %If user selects Quantum box
	    answer := "quantum" %Sets correct answer
	    userInput %Gets guess
	    if Str.Lower (guess) = answer then %If guess is correct
		correctAnswer %Correct text
		%Inputs QUANTUM into boxes
		Font.Draw ("Q", 40, 640, crosswordFont2, black)
		Font.Draw ("U", 40, 610, crosswordFont2, black)
		Font.Draw ("A", 40, 580, crosswordFont2, black)
		Font.Draw ("N", 40, 550, crosswordFont2, black)
		Font.Draw ("T", 40, 520, crosswordFont2, black)
		Font.Draw ("U", 40, 490, crosswordFont2, black)
		Font.Draw ("M", 40, 458, crosswordFont2, black)
		winChecker (1) := 1 %Sets array winChecker(1) a value of 1
	    else %If guess is wrong
		wrongAnswer %Wrong text
	    end if
	end if
	if mouseX > 30 and mouseX < 60 and mouseY > 450 and mouseY < 480 and button = 1 then %If user selects Mac box
	    answer := "mac" %Sets correct answer
	    userInput %Gets guess
	    if Str.Lower (guess) = answer then %If guess is correct
		correctAnswer %Correct text
		%Inputs MAC into boxes
		Font.Draw ("M", 40, 458, crosswordFont2, black)
		Font.Draw ("A", 70, 458, crosswordFont2, black)
		Font.Draw ("C", 100, 458, crosswordFont2, black)
		winChecker (2) := 1 %Sets array winChecker(2) a value of 1
	    else %If guess is wrong
		wrongAnswer %Wrong text
	    end if
	end if
	if mouseX > 30 and mouseX < 60 and mouseY > 540 and mouseY < 570 and button = 1 then %If user selects Network box
	    answer := "network" %Sets correct answer
	    userInput %Gets guess
	    if Str.Lower (guess) = answer then %If guess is correct
		correctAnswer %Correct text
		%Inputs NETWORK into boxes
		Font.Draw ("N", 40, 550, crosswordFont2, black)
		Font.Draw ("E", 70, 550, crosswordFont2, black)
		Font.Draw ("T", 100, 550, crosswordFont2, black)
		Font.Draw ("W", 130, 550, crosswordFont2, black)
		Font.Draw ("O", 160, 550, crosswordFont2, black)
		Font.Draw ("R", 190, 550, crosswordFont2, black)
		Font.Draw ("K", 220, 550, crosswordFont2, black)
		winChecker (3) := 1 %Sets array winChecker(3) a value of 1
	    else %If guess is wrong
		wrongAnswer %Wrong text
	    end if
	end if
	if mouseX > 90 and mouseX < 120 and mouseY > 720 and mouseY < 750 and button = 1 then %If user selects Comment box
	    answer := "comment" %Sets correct answer
	    userInput %Gets guess
	    if Str.Lower (guess) = answer then %If guess is correct
		correctAnswer %Correct text
		%Inputs COMMENT into boxes
		Font.Draw ("C", 100, 730, crosswordFont2, black)
		Font.Draw ("O", 100, 700, crosswordFont2, black)
		Font.Draw ("M", 100, 670, crosswordFont2, black)
		Font.Draw ("M", 100, 640, crosswordFont2, black)
		Font.Draw ("E", 100, 610, crosswordFont2, black)
		Font.Draw ("N", 100, 580, crosswordFont2, black)
		Font.Draw ("T", 100, 550, crosswordFont2, black)
		winChecker (4) := 1 %Sets array winChecker(4) a value of 1
	    else %If guess is wrong
		wrongAnswer %Wrong text
	    end if
	end if
	if mouseX > 90 and mouseX < 120 and mouseY > 660 and mouseY < 690 and button = 1 then %If user selects Megabyte box
	    answer := "megabyte" %Sets correct answer
	    userInput %Gets guess
	    if Str.Lower (guess) = answer then %If guess is correct
		correctAnswer %Correct text
		%Inputs MEGABYTE into boxes
		Font.Draw ("M", 100, 670, crosswordFont2, black)
		Font.Draw ("E", 130, 670, crosswordFont2, black)
		Font.Draw ("G", 160, 670, crosswordFont2, black)
		Font.Draw ("A", 190, 670, crosswordFont2, black)
		Font.Draw ("B", 220, 670, crosswordFont2, black)
		Font.Draw ("Y", 250, 670, crosswordFont2, black)
		Font.Draw ("T", 280, 670, crosswordFont2, black)
		Font.Draw ("E", 310, 670, crosswordFont2, black)
		winChecker (5) := 1 %Sets array winChecker(5) a value of 1
	    else %If guess is wrong
		wrongAnswer %Wrong text
	    end if
	end if
	if mouseX > 180 and mouseX < 210 and mouseY > 690 and mouseY < 720 and button = 1 then %If user selects Malware box
	    answer := "malware" %Sets correct answer
	    userInput %Gets guess
	    if Str.Lower (guess) = answer then %If guess is correct
		correctAnswer %Correct text
		%Inputs MALWARE into boxes
		Font.Draw ("M", 190, 700, crosswordFont2, black)
		Font.Draw ("A", 190, 670, crosswordFont2, black)
		Font.Draw ("L", 190, 640, crosswordFont2, black)
		Font.Draw ("W", 190, 610, crosswordFont2, black)
		Font.Draw ("A", 190, 580, crosswordFont2, black)
		Font.Draw ("R", 190, 550, crosswordFont2, black)
		Font.Draw ("E", 190, 520, crosswordFont2, black)
		winChecker (6) := 1 %Sets array winChecker(6) a value of 1
	    else %If guess is wrong
		wrongAnswer %Wrong text
	    end if
	end if
	if mouseX > 180 and mouseX < 210 and mouseY > 600 and mouseY < 630 and button = 1 then %If user selects Windows box
	    answer := "windows" %Sets correct answer
	    userInput %Gets guess
	    if Str.Lower (guess) = answer then %If guess is correct
		correctAnswer %Correct text
		%Inputs WINDOWS into boxes
		Font.Draw ("W", 190, 610, crosswordFont2, black)
		Font.Draw ("I", 220, 610, crosswordFont2, black)
		Font.Draw ("N", 250, 610, crosswordFont2, black)
		Font.Draw ("D", 280, 610, crosswordFont2, black)
		Font.Draw ("O", 310, 610, crosswordFont2, black)
		Font.Draw ("W", 340, 610, crosswordFont2, black)
		Font.Draw ("S", 370, 610, crosswordFont2, black)
		winChecker (7) := 1 %Sets array winChecker(7) a value of 1
	    else %If guess is wrong
		wrongAnswer %Wrong text
	    end if
	end if
	if mouseX > 360 and mouseX < 390 and mouseY > 600 and mouseY < 630 and button = 1 then %If user selects String box
	    answer := "string" %Sets correct answer
	    userInput %Gets guess
	    if Str.Lower (guess) = answer then %If guess is correct
		correctAnswer %Correct text
		%Inputs STRING into boxes
		Font.Draw ("S", 370, 610, crosswordFont2, black)
		Font.Draw ("T", 370, 580, crosswordFont2, black)
		Font.Draw ("R", 370, 550, crosswordFont2, black)
		Font.Draw ("I", 370, 518, crosswordFont2, black)
		Font.Draw ("N", 370, 490, crosswordFont2, black)
		Font.Draw ("G", 370, 458, crosswordFont2, black)
		winChecker (8) := 1 %Sets array winChecker(8) a value of 1
	    else %If guess is wrong
		wrongAnswer %Wrong text
	    end if
	end if
	if mouseX > 300 and mouseX < 330 and mouseY > 510 and mouseY < 540 and button = 1 then %If user selects Eniac box
	    answer := "eniac" %Sets correct answer
	    userInput %Gets guess
	    if Str.Lower (guess) = answer then %If guess is correct
		correctAnswer %Correct text
		%Inputs ENIAC into boxes
		Font.Draw ("E", 310, 518, crosswordFont2, black)
		Font.Draw ("N", 340, 518, crosswordFont2, black)
		Font.Draw ("I", 370, 518, crosswordFont2, black)
		Font.Draw ("A", 400, 518, crosswordFont2, black)
		Font.Draw ("C", 430, 518, crosswordFont2, black)
		winChecker (9) := 1 %Sets array winChecker(9) a value of 1
	    else %If guess is wrong
		wrongAnswer %Wrong text
	    end if
	end if
	if mouseX > 360 and mouseX < 390 and mouseY > 450 and mouseY < 480 and button = 1 then %If user selects Global box
	    answer := "global" %Sets correct answer
	    userInput %Gets guess
	    if Str.Lower (guess) = answer then %If guess is correct
		correctAnswer %Correct text
		%Inputs GLOBAL into boxes
		Font.Draw ("G", 370, 458, crosswordFont2, black)
		Font.Draw ("L", 400, 458, crosswordFont2, black)
		Font.Draw ("O", 430, 458, crosswordFont2, black)
		Font.Draw ("B", 460, 458, crosswordFont2, black)
		Font.Draw ("A", 490, 458, crosswordFont2, black)
		Font.Draw ("L", 520, 458, crosswordFont2, black)
		winChecker (10) := 1 %Sets array winChecker(10) a value of 1
	    else %If guess is wrong
		wrongAnswer %Wrong text
	    end if
	end if
	if mouseX > 450 and mouseX < 480 and mouseY > 450 and mouseY < 480 and button = 1 then %If user selects Babbage box
	    answer := "babbage" %Sets correct answer
	    userInput %Gets guess
	    if Str.Lower (guess) = answer then %If guess is correct
		correctAnswer %Correct text
		%Inputs BABBAGE into boxes
		Font.Draw ("B", 460, 458, crosswordFont2, black)
		Font.Draw ("A", 460, 430, crosswordFont2, black)
		Font.Draw ("B", 460, 400, crosswordFont2, black)
		Font.Draw ("B", 460, 370, crosswordFont2, black)
		Font.Draw ("A", 460, 338, crosswordFont2, black)
		Font.Draw ("G", 460, 310, crosswordFont2, black)
		Font.Draw ("E", 460, 278, crosswordFont2, black)
		winChecker (11) := 1 %Sets array winChecker(11) a value of 1
	    else %If guess is wrong
		wrongAnswer %Wrong text
	    end if
	end if
	if mouseX > 360 and mouseX < 390 and mouseY > 330 and mouseY < 360 and button = 1 then %If user selects Binary box
	    answer := "binary" %Sets correct answer
	    userInput %Gets guess
	    if Str.Lower (guess) = answer then %If guess is correct
		correctAnswer %Correct text
		%Inputs BINARY into boxes
		Font.Draw ("B", 370, 338, crosswordFont2, black)
		Font.Draw ("I", 400, 338, crosswordFont2, black)
		Font.Draw ("N", 430, 338, crosswordFont2, black)
		Font.Draw ("A", 460, 338, crosswordFont2, black)
		Font.Draw ("R", 490, 338, crosswordFont2, black)
		Font.Draw ("Y", 520, 338, crosswordFont2, black)
		winChecker (12) := 1 %Sets array winChecker(12) a value of 1
	    else %If guess is wrong
		wrongAnswer %Wrong text
	    end if
	end if
	if mouseX > 360 and mouseX < 390 and mouseY > 270 and mouseY < 300 and button = 1 then %If user selects Indent box
	    answer := "indent" %Sets correct answer
	    userInput %Gets guess
	    if Str.Lower (guess) = answer then %If guess is correct
		correctAnswer %Correct text
		%Inputs INDENT into boxes
		Font.Draw ("I", 370, 278, crosswordFont2, black)
		Font.Draw ("N", 400, 278, crosswordFont2, black)
		Font.Draw ("D", 430, 278, crosswordFont2, black)
		Font.Draw ("E", 460, 278, crosswordFont2, black)
		Font.Draw ("N", 490, 278, crosswordFont2, black)
		Font.Draw ("T", 520, 278, crosswordFont2, black)
		winChecker (13) := 1 %Sets array winChecker(13) a value of 1
	    else %If guess is wrong
		wrongAnswer %Wrong text
	    end if
	end if
	if mouseX > 510 and mouseX < 540 and mouseY > 570 and mouseY < 600 and button = 1 then %If user selects Modulus box
	    answer := "modulus" %Sets correct answer
	    userInput %Gets guess
	    if Str.Lower (guess) = answer then %If guess is correct
		correctAnswer %Correct text
		%Inputs MODULUS into boxes
		Font.Draw ("M", 520, 580, crosswordFont2, black)
		Font.Draw ("O", 520, 550, crosswordFont2, black)
		Font.Draw ("D", 520, 520, crosswordFont2, black)
		Font.Draw ("U", 520, 490, crosswordFont2, black)
		Font.Draw ("L", 520, 458, crosswordFont2, black)
		Font.Draw ("U", 520, 430, crosswordFont2, black)
		Font.Draw ("S", 520, 398, crosswordFont2, black)
		winChecker (14) := 1 %Sets array winChecker(14) a value of 1
	    else %If guess is wrong
		wrongAnswer %Wrong text
	    end if
	end if
	if mouseX > 510 and mouseX < 540 and mouseY > 390 and mouseY < 420 and button = 1 then %If user selects SSD box
	    answer := "ssd" %Sets correct answer
	    userInput %Gets guess
	    if Str.Lower (guess) = answer then %If guess is correct
		correctAnswer %Correct text
		%Inputs SSD into boxes
		Font.Draw ("S", 520, 398, crosswordFont2, black)
		Font.Draw ("S", 550, 398, crosswordFont2, black)
		Font.Draw ("D", 580, 398, crosswordFont2, black)
		winChecker (15) := 1 %Sets array winChecker(15) a value of 1
	    else %If guess is wrong
		wrongAnswer %Wrong text
	    end if
	end if
	if mouseX > 480 and mouseX < 510 and mouseY > 540 and mouseY < 570 and button = 1 then %If user selects For box
	    answer := "for" %Sets correct answer
	    userInput %Gets guess
	    if Str.Lower (guess) = answer then %If guess is correct
		correctAnswer %Correct text
		%Inputs FOR into boxes
		Font.Draw ("F", 490, 550, crosswordFont2, black)
		Font.Draw ("O", 520, 550, crosswordFont2, black)
		Font.Draw ("R", 550, 550, crosswordFont2, black)
		winChecker (16) := 1 %Sets array winChecker(16) a value of 1
	    else %If guess is wrong
		wrongAnswer %Wrong text
	    end if
	end if
	%Checks if all crosswords have been completed
	if winChecker (1) + winChecker (2) + winChecker (3) + winChecker (4) + winChecker (5) + winChecker (6) + winChecker (7) + winChecker (8) +
		winChecker (9) + winChecker (10) + winChecker (11) + winChecker (12) + winChecker (13) + winChecker (14) + winChecker (15) + winChecker (16) = 16 then
	    endMsgVar := 2 %If all boxes have been completed, sets endMsgVar to 2 - Win
	    exit %Exits loop
	end if
	%If user clicks on Give up box
	if mouseX > 575 and mouseX < 725 and mouseY > 125 and mouseY < 225 and button = 1 then
	    endMsgVar := 1 %Selects endMsgVar to 1 - Loss
	    exit %Exits loop
	end if
    end loop
    endMessage %Goes to endMessage
end puzzle2

%Puzzle3 - display and processing
procedure puzzle3
    crosswordTitle %Refreshes screen, with correct title
    puzzle3Graphics %Loads boxes and graphics for puzzle3
    pauseProgram %Pauses program - tells user how to play, in case they did not read instructions
    %Timer, if user selects so
    if timedMode = 1 then %If timer is activated
	timerUserInput %Gets minutes
    end if
    %Draws Give up box
    drawbox (795, 175, 645, 75, 7) %Draws box
    Font.Draw ("Give up?", 672, 117, titleFont, 7) %Text
    %Loop - Timer and mousewhere
    loop
	%Timer
	if timedMode = 1 then %If timed mode is activated
	    timerCounter %Counts time
	    if intMinutes < 0 then %If time is up
		endMsgVar := 1 %Sets endMsgVar to 1 - Loss
		exit %Exits loop
	    end if
	end if
	%Mousewhere and userInput
	mousewhere (mouseX, mouseY, button) %Sets parameters for mousewhere
	if mouseX > 30 and mouseX < 60 and mouseY > 730 and mouseY < 760 and button = 1 then %If user selects ROM box
	    answer := "rom" %Sets correct answer
	    userInput %Gets guess
	    if Str.Lower (guess) = answer then %If guess is correct
		correctAnswer %Correct text
		%Imports ROM into boxes
		Font.Draw ("R", 40, 740, crosswordFont2, black)
		Font.Draw ("O", 40, 710, crosswordFont2, black)
		Font.Draw ("M", 40, 680, crosswordFont2, black)
		winChecker (1) := 1 %Sets array winChecker(1) a value of 1
	    else %If guess is wrong
		wrongAnswer %Wrong text
	    end if
	end if
	if mouseX > 30 and mouseX < 60 and mouseY > 670 and mouseY < 700 and button = 1 then %If user selects Monitor box
	    answer := "monitor" %Sets correct answer
	    userInput %Gets guess
	    if Str.Lower (guess) = answer then %If guess is correct
		correctAnswer %Correct text
		%Imports MONITOR into boxes
		Font.Draw ("M", 40, 680, crosswordFont2, black)
		Font.Draw ("O", 70, 680, crosswordFont2, black)
		Font.Draw ("N", 100, 680, crosswordFont2, black)
		Font.Draw ("I", 130, 680, crosswordFont2, black)
		Font.Draw ("T", 160, 680, crosswordFont2, black)
		Font.Draw ("O", 190, 680, crosswordFont2, black)
		Font.Draw ("R", 220, 680, crosswordFont2, black)
		winChecker (2) := 1 %Sets array winChecker(2) a value of 1
	    else %If guess is wrong
		wrongAnswer %Wrong text
	    end if
	end if
	if mouseX > 90 and mouseX < 120 and mouseY > 730 and mouseY < 760 and button = 1 then %If user selects Fan box
	    answer := "fan" %Sets correct answer
	    userInput %Gets guess
	    if Str.Lower (guess) = answer then %If guess is correct
		correctAnswer %Correct text
		%Imports FAN into boxes
		Font.Draw ("F", 100, 740, crosswordFont2, black)
		Font.Draw ("A", 100, 710, crosswordFont2, black)
		Font.Draw ("N", 100, 680, crosswordFont2, black)
		winChecker (3) := 1 %Sets array winChecker(3) a value of 1
	    else %If guess is wrong
		wrongAnswer %Wrong text
	    end if
	end if
	if mouseX > 180 and mouseX < 210 and mouseY > 700 and mouseY < 730 and button = 1 then %If user selects Motherboard box
	    answer := "motherboard" %Sets correct answer
	    userInput %Gets guess
	    if Str.Lower (guess) = answer then %If guess is correct
		correctAnswer %Correct text
		%Imports MOTHERBOARD into boxes
		Font.Draw ("M", 190, 710, crosswordFont2, black)
		Font.Draw ("O", 190, 680, crosswordFont2, black)
		Font.Draw ("T", 190, 650, crosswordFont2, black)
		Font.Draw ("H", 190, 620, crosswordFont2, black)
		Font.Draw ("E", 190, 590, crosswordFont2, black)
		Font.Draw ("R", 190, 560, crosswordFont2, black)
		Font.Draw ("B", 190, 530, crosswordFont2, black)
		Font.Draw ("O", 190, 500, crosswordFont2, black)
		Font.Draw ("A", 190, 470, crosswordFont2, black)
		Font.Draw ("R", 190, 440, crosswordFont2, black)
		Font.Draw ("D", 190, 410, crosswordFont2, black)
		winChecker (4) := 1 %Sets array winChecker(4) a value of 1
	    else %If guess is wrong
		wrongAnswer %Wrong text
	    end if
	end if
	if mouseX > 150 and mouseX < 180 and mouseY > 580 and mouseY < 610 and button = 1 then %If user selects Peripheral box
	    answer := "peripheral" %Sets correct answer
	    userInput %Gets guess
	    if Str.Lower (guess) = answer then %If guess is correct
		correctAnswer %Correct text
		%Imports PERIPHERAL into boxes
		Font.Draw ("P", 162, 590, crosswordFont2, black)
		Font.Draw ("E", 190, 590, crosswordFont2, black)
		Font.Draw ("R", 220, 590, crosswordFont2, black)
		Font.Draw ("I", 252, 590, crosswordFont2, black)
		Font.Draw ("P", 280, 590, crosswordFont2, black)
		Font.Draw ("H", 310, 590, crosswordFont2, black)
		Font.Draw ("E", 340, 590, crosswordFont2, black)
		Font.Draw ("R", 370, 590, crosswordFont2, black)
		Font.Draw ("A", 400, 590, crosswordFont2, black)
		Font.Draw ("L", 430, 590, crosswordFont2, black)
		winChecker (5) := 1 %Sets array winChecker(5) a value of 1
	    else %If guess is wrong
		wrongAnswer %Wrong text
	    end if
	end if
	if mouseX > 30 and mouseX < 60 and mouseY > 460 and mouseY < 490 and button = 1 then %If user selects Camera box
	    answer := "camera" %Sets correct answer
	    userInput %Gets guess
	    if Str.Lower (guess) = answer then %If guess is correct
		correctAnswer %Correct text
		%Imports CAMERA into boxes
		Font.Draw ("C", 42, 470, crosswordFont2, black)
		Font.Draw ("A", 72, 470, crosswordFont2, black)
		Font.Draw ("M", 100, 470, crosswordFont2, black)
		Font.Draw ("E", 130, 470, crosswordFont2, black)
		Font.Draw ("R", 160, 470, crosswordFont2, black)
		Font.Draw ("A", 190, 470, crosswordFont2, black)
		winChecker (6) := 1 %Sets array winChecker(6) a value of 1
	    else %If guess is wrong
		wrongAnswer %Wrong text
	    end if
	end if
	if mouseX > 60 and mouseX < 90 and mouseY > 460 and mouseY < 490 and button = 1 then %If user selects ALU box
	    answer := "alu" %Sets correct answer
	    userInput %Gets guess
	    if Str.Lower (guess) = answer then %If guess is correct
		correctAnswer %Correct text
		%Imports ALU into boxes
		Font.Draw ("A", 72, 470, crosswordFont2, black)
		Font.Draw ("L", 72, 440, crosswordFont2, black)
		Font.Draw ("U", 72, 410, crosswordFont2, black)
		winChecker (7) := 1 %Sets array winChecker(7) a value of 1
	    else %If guess is wrong
		wrongAnswer %Wrong text
	    end if
	end if
	if mouseX > 120 and mouseX < 150 and mouseY > 550 and mouseY < 580 and button = 1 then %If user selects Case box
	    answer := "case" %Sets correct answer
	    userInput %Gets guess
	    if Str.Lower (guess) = answer then %If guess is correct
		correctAnswer %Correct text
		%Imports CASE into boxes
		Font.Draw ("C", 130, 560, crosswordFont2, black)
		Font.Draw ("A", 130, 530, crosswordFont2, black)
		Font.Draw ("S", 130, 500, crosswordFont2, black)
		Font.Draw ("E", 130, 470, crosswordFont2, black)
		winChecker (8) := 1 %Sets array winChecker(8) a value of 1
	    else %If guess is wrong
		wrongAnswer %Wrong text
	    end if
	end if
	if mouseX > 240 and mouseX < 270 and mouseY > 610 and mouseY < 640 and button = 1 then %If user selects Microphone box
	    answer := "microphone" %Sets correct answer
	    userInput %Gets guess
	    if Str.Lower (guess) = answer then %If guess is correct
		correctAnswer %Correct text
		%Imports MICROPHONE into boxes
		Font.Draw ("M", 252, 620, crosswordFont2, black)
		Font.Draw ("I", 252, 590, crosswordFont2, black)
		Font.Draw ("C", 252, 560, crosswordFont2, black)
		Font.Draw ("R", 252, 530, crosswordFont2, black)
		Font.Draw ("O", 252, 500, crosswordFont2, black)
		Font.Draw ("P", 252, 470, crosswordFont2, black)
		Font.Draw ("H", 252, 440, crosswordFont2, black)
		Font.Draw ("O", 252, 410, crosswordFont2, black)
		Font.Draw ("N", 252, 380, crosswordFont2, black)
		Font.Draw ("E", 252, 350, crosswordFont2, black)
		winChecker (9) := 1 %Sets array winChecker(9) a value of 1
	    else %If guess is wrong
		wrongAnswer %Wrong text
	    end if
	end if
	if mouseX > 330 and mouseX < 360 and mouseY > 700 and mouseY < 730 and button = 1 then %If user selects Mouse box
	    answer := "mouse" %Sets correct answer
	    userInput %Gets guess
	    if Str.Lower (guess) = answer then %If guess is correct
		correctAnswer %Correct text
		%Imports MOUSE into boxes
		Font.Draw ("M", 340, 710, crosswordFont2, black)
		Font.Draw ("O", 340, 680, crosswordFont2, black)
		Font.Draw ("U", 340, 650, crosswordFont2, black)
		Font.Draw ("S", 340, 620, crosswordFont2, black)
		Font.Draw ("E", 340, 590, crosswordFont2, black)
		winChecker (10) := 1 %Sets array winChecker(10) a value of 1
	    else %If guess is wrong
		wrongAnswer %Wrong text
	    end if
	end if
	if mouseX > 390 and mouseX < 420 and mouseY > 730 and mouseY < 760 and button = 1 then %If user selects Keyboard box
	    answer := "keyboard" %Sets correct answer
	    userInput %Gets guess
	    if Str.Lower (guess) = answer then %If guess is correct
		correctAnswer %Correct text
		%Imports KEYBOARD into boxes
		Font.Draw ("K", 400, 740, crosswordFont2, black)
		Font.Draw ("E", 400, 710, crosswordFont2, black)
		Font.Draw ("Y", 400, 680, crosswordFont2, black)
		Font.Draw ("B", 400, 650, crosswordFont2, black)
		Font.Draw ("O", 400, 620, crosswordFont2, black)
		Font.Draw ("A", 400, 590, crosswordFont2, black)
		Font.Draw ("R", 400, 560, crosswordFont2, black)
		Font.Draw ("D", 400, 530, crosswordFont2, black)
		winChecker (11) := 1 %Sets array winChecker(11) a value of 1
	    else %If guess is wrong
		wrongAnswer %Wrong text
	    end if
	end if
	if mouseX > 270 and mouseX < 300 and mouseY > 640 and mouseY < 670 and button = 1 then %If user selects GPU box
	    answer := "gpu" %Sets correct answer
	    userInput %Gets guess
	    if Str.Lower (guess) = answer then %If guess is correct
		correctAnswer %Correct text
		%Imports GPU into boxes
		Font.Draw ("G", 280, 650, crosswordFont2, black)
		Font.Draw ("P", 310, 650, crosswordFont2, black)
		Font.Draw ("U", 340, 650, crosswordFont2, black)
		winChecker (12) := 1 %Sets array winChecker(12) a value of 1
	    else %If guess is wrong
		wrongAnswer %Wrong text
	    end if
	end if
	if mouseX > 240 and mouseX < 270 and mouseY > 520 and mouseY < 550 and button = 1 then %If user selects RAM box
	    answer := "ram" %Sets correct answer
	    userInput %Gets guess
	    if Str.Lower (guess) = answer then %If guess is correct
		correctAnswer %Correct text
		%Imports RAM into boxes
		Font.Draw ("R", 252, 530, crosswordFont2, black)
		Font.Draw ("A", 280, 530, crosswordFont2, black)
		Font.Draw ("M", 310, 530, crosswordFont2, black)
		winChecker (13) := 1 %Sets array winChecker(13) a value of 1
	    else %If guess is wrong
		wrongAnswer %Wrong text
	    end if
	end if
	if mouseX > 240 and mouseX < 270 and mouseY > 460 and mouseY < 490 and button = 1 then %If user selects Processor box
	    answer := "processor" %Sets correct answer
	    userInput %Gets guess
	    if Str.Lower (guess) = answer then %If guess is correct
		correctAnswer %Correct text
		%Imports PROCESSOR into boxes
		Font.Draw ("P", 252, 470, crosswordFont2, black)
		Font.Draw ("R", 282, 470, crosswordFont2, black)
		Font.Draw ("O", 312, 470, crosswordFont2, black)
		Font.Draw ("C", 342, 470, crosswordFont2, black)
		Font.Draw ("E", 372, 470, crosswordFont2, black)
		Font.Draw ("S", 402, 470, crosswordFont2, black)
		Font.Draw ("S", 432, 470, crosswordFont2, black)
		Font.Draw ("O", 462, 470, crosswordFont2, black)
		Font.Draw ("R", 492, 470, crosswordFont2, black)
		winChecker (14) := 1 %Sets array winChecker(14) a value of 1
	    else %If guess is wrong
		wrongAnswer %Wrong text
	    end if
	end if
	if mouseX > 420 and mouseX < 450 and mouseY > 490 and mouseY < 520 and button = 1 then %If user selects PSU box
	    answer := "psu" %Sets correct answer
	    userInput %Gets guess
	    if Str.Lower (guess) = answer then %If guess is correct
		correctAnswer %Correct text
		%Imports PSU into boxes
		Font.Draw ("P", 432, 500, crosswordFont2, black)
		Font.Draw ("S", 432, 470, crosswordFont2, black)
		Font.Draw ("U", 432, 440, crosswordFont2, black)
		winChecker (15) := 1 %Sets array winChecker(15) a value of 1
	    else %If guess is wrong
		wrongAnswer %Wrong text
	    end if
	end if
	if mouseX > 480 and mouseX < 510 and mouseY > 640 and mouseY < 670 and button = 1 then %If user selects Speaker box
	    answer := "speaker" %Sets correct answer
	    userInput %Gets guess
	    if Str.Lower (guess) = answer then %If guess is correct
		correctAnswer %Correct text
		%Imports SPEAKER into boxes
		Font.Draw ("S", 492, 650, crosswordFont2, black)
		Font.Draw ("P", 492, 620, crosswordFont2, black)
		Font.Draw ("E", 492, 590, crosswordFont2, black)
		Font.Draw ("A", 492, 560, crosswordFont2, black)
		Font.Draw ("K", 492, 530, crosswordFont2, black)
		Font.Draw ("E", 492, 500, crosswordFont2, black)
		Font.Draw ("R", 492, 470, crosswordFont2, black)
		winChecker (16) := 1 %Sets array winChecker(16) a value of 1
	    else %If guess is wrong
		wrongAnswer %Wrong text
	    end if
	end if

	if winChecker (1) + winChecker (2) + winChecker (3) + winChecker (4) + winChecker (5) + winChecker (6) + winChecker (7) + winChecker (8) +
		winChecker (9) + winChecker (10) + winChecker (11) + winChecker (12) + winChecker (13) + winChecker (14) + winChecker (15) + winChecker (16) = 16 then
	    endMsgVar := 2
	    exit
	end if
	%Give up / exit box
	if mouseX > 645 and mouseX < 795 and mouseY > 75 and mouseY < 175 and button = 1 then
	    endMsgVar := 1
	    exit
	end if
    end loop
    endMessage
end puzzle3

%Chooses a random puzzle for user to try
body procedure randomPuzzleChooser
    for x : 1 .. 16 %Assigns all variables in array winChecker a value of 0 - resets score
	winChecker (x) := 0 %Assigns values
    end for
    randint (puzzleNum, 1, 3) %Chooses a random puzzle
    if puzzleNum = 1 then %If randomizer chooses puzzle1
	puzzle1 %Goes to puzzle1
    elsif puzzleNum = 2 then %If randomizer chooses puzzle2
	puzzle2 %Goes to puzzle2
    elsif puzzleNum = 3 then %If randomizer chooses puzzle3
	puzzle3 %Goes to puzzle3
    end if
end randomPuzzleChooser

%Main Program
introduction
loop
    exit when GUI.ProcessEvent
end loop
goodbye
%End Program
