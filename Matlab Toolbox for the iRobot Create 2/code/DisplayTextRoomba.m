function DisplayTextRoomba(serPort, FourLetterString)
% DisplayText(serPort, FourCharacterString)
% Displays text on Roomba's display
% FourCharacterString is a four character, case sensitive, string
% ASCII character codes 32 through 126 are supported, which includes all letters
% (upper and lowercase), numbers and punctuation
% All ASCII Characters are only an approximation on 7 segment displays.
% Strings with less than 4 characters will have spaces appended to them.
% serPort is a serial port object created by RoombaInit.
% by Joel Esposito, US Naval Acamdey 2015

if length(FourLetterString) > 4
    error('String length cannot exceed 4 characters.')
end
FourLetterString = uint8(FourLetterString);
while length(FourLetterString)<4
    FourLetterString = [FourLetterString,32];
end
fwrite(serPort, [164, FourLetterString]);

