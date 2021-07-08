% tested in MATLAB 2018/b
Fs			= 10000;            % Sampling frequency
T 			= 1/Fs;             % Sampling period
L 			= 400;              % Length of signal 40 ms
t 			= (0:L-1)*T;        % Time vector
S_noisy 	= 0.5 + 0.5*sin(2*pi*1000*t) + 1*sin(2*pi*50*t);
S_noisy 	= single(S_noisy);
S_noisy_hex = num2hex(S_noisy);
dlmwrite('sin_noisy.txt',S_noisy_hex,'delimiter','\n');
% olusan dosyada her bir karatker bir satirda, onu noteped++'da makro ile duzeltebilirsiniz

% table olarak ve text veri tipinde import edilen veriyi okumak icin
% text (String) tipinde secilecek
% output type -> table
% TEXT TYPE -> cell array of character vectors
filter_out_noisy = hexsingle2num(filteroutnoisy.Variables);

% filtre giris ve cikisi ust uste cizdirmek
plot(filter_out_noisy,'DisplayName','filter_out_noisy');hold on;plot(S_noisy,'DisplayName','S_noisy');hold off;