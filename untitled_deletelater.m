%aaa = [1 2 3; 4 1 2; 5 1 3; 9 1 3; 3 4 0; 0 1 3; 7 8 8];

%bbb = sortrows(aaa);

%ccc = bbb(size(aaa,1):-1:1,:);

%aaa = [1; 3; 2; 1; 0; 0; 0; 0; 1; 1; 2];

%find(aaa == 0)

i = 1;
while i < 5
   i = i + 1
end