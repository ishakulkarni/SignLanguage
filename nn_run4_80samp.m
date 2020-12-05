

load('run4cell16block4.mat')  %input data.
load('t_run4_80.mat') %target data

x = mh';     %   mh - input data.
t = data';   %   data - target data.

% 'trainscg' uses less memory. Suitable in low memory situations.
trainFcn = 'trainscg';  % Scaled conjugate gradient backpropagation.

% Create a Pattern Recognition Network
hiddenLayerSize = 78;
net = patternnet(hiddenLayerSize, trainFcn);   %Pattern recognition networks are feedforward networks 
                                               %that can be trained to classify inputs according to target classes.
                                               
% Setup Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 75/100;
net.divideParam.valRatio = 10/100;
net.divideParam.testRatio = 15/100;

% Train the Network
[net,tr] = train(net,x,t);

% Test the Network
y = net(x);
e = gsubtract(t,y);             %Generalized subtraction--error calculation-takes two matrices or cell arrays, and subtracts them in an element-wise manner.
performance = perform(net,t,y); %Calculate network performance from target and output data
tind = vec2ind(t);              %Convert vectors to indices
yind = vec2ind(y);
percentErrors = sum(tind ~= yind)/numel(tind);

% View the Network
view(net) 
% %  genFunction(net,'netwts');

  
% save netnet net -v7.3 
% crossentropy=calculates a network performance from given targets and outputs, 
%              with optional performance weights and other parameters. 
% The function returns a result that heavily penalizes outputs that are extremely inaccurate (y near 1-t),
%      with very little penalty for fairly correct classifications (y near t). 
% Minimizing cross-entropy leads to good classifiers. 

