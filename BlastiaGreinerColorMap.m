function [ mymap ] = BlastiaGreinerColorMap( whitemax )
%whitemax = 0.25;
  maplength=128;
  whiteindex = maplength*whitemax;
  myjet = jet(maplength*(1+1/8-whitemax));
  firstblue = find(myjet(:,3)==1,1);
  mymapones = ones(whiteindex+1,1);
  mymapgrad = (1:-1/(whiteindex):0)';
  mymap = [mymapgrad mymapgrad mymapones];
  mymap = [mymap; myjet(firstblue:end,:)];
end

