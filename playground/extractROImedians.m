for i = 1:131
    a(i,:) = stat(i).med;
end
csvwrite('/Users/ananth/Desktop/session6',a)