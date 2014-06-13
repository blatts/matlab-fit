function finalString = ErrorWrite(valStr, errStr)
%ErrorWrite: Takes two formatted strings, (a value and its error written in
%scientific notation and extresses it in the form val(err)e-valOOM
%   Detailed explanation goes here
  [valP1, rem1] = strtok(valStr, 'e');
  [valP2, rem2] = strtok(rem1, 'e');

  [errP1, rem1] = strtok(errStr, 'e');
  [errP2, rem2] = strtok(rem1, 'e');

  valNum = str2num(valP1);
  valOOM = str2num(valP2); %Value Order of Magnitude

  errNum = str2num(errP1);
  errOOM = str2num(errP2); %Error Order of Magnitude

  OOMdiff = valOOM-errOOM;

  if OOMdiff >= 0
    valF = sprintf('%1.*f', OOMdiff, valNum);
    errF = sprintf('%.0f', errNum);
    finalString = strcat(num2str(valF), '(', num2str(errF),') E', num2str(valOOM));
  else
    finalString = strcat(valP1, '(ETB) E', num2str(valP2));
  end
end
