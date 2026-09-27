net = efficientnetb0;

for i = length(net.Layers)-20:length(net.Layers)
    disp(i)
    disp(net.Layers(i).Name)
end