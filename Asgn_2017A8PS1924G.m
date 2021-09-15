function varargout = Asgn_2017A8PS1924G(varargin)
% ASGN_2017A8PS1924G MATLAB code for Asgn_2017A8PS1924G.fig
%      ASGN_2017A8PS1924G, by itself, creates a new ASGN_2017A8PS1924G or raises the existing
%      singleton*.
%
%      H = ASGN_2017A8PS1924G returns the handle to a new ASGN_2017A8PS1924G or the handle to
%      the existing singleton*.
%
%      ASGN_2017A8PS1924G('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ASGN_2017A8PS1924G.M with the given input arguments.
%
%      ASGN_2017A8PS1924G('Property','Value',...) creates a new ASGN_2017A8PS1924G or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Asgn_2017A8PS1924G_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Asgn_2017A8PS1924G_OpeningFcn via varargin.
%
%      *See GUI time_domain on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Asgn_2017A8PS1924G

% Last Modified by GUIDE v2.5 22-Apr-2021 16:09:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Asgn_2017A8PS1924G_OpeningFcn, ...
                   'gui_OutputFcn',  @Asgn_2017A8PS1924G_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Outputs from this function are returned to the command line.
function varargout = Asgn_2017A8PS1924G_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% OPENING FUNCTION

% --- Executes just before Asgn_2017A8PS1924G is made visible.
function Asgn_2017A8PS1924G_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Asgn_2017A8PS1924G (see VARARGIN)

% Choose default command line output for Asgn_2017A8PS1924G
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Asgn_2017A8PS1924G wait for user response (see UIRESUME)
% uiwait(handles.figure1);

handles.k_max = 5;
for i = 1:handles.k_max
    
    % Dynamically adding a static text field for Amplitude
    handles.A_text(i) = uicontrol('parent', handles.uipanel2, 'style',...
        'text', 'string', sprintf('A%d', i), 'position', ...
        [12, 219 - 40*(i-1), 44, 19], 'FontSize', 10);
    
    % Dynamically adding an edit text field for Amplitude
    handles.A_value(i) = uicontrol('parent', handles.uipanel2, 'style',...
        'edit', 'string', '1', 'position',... 
        [62, 218 - 40*(i-1), 78, 22], 'FontSize', 10, 'Value', 1,...
        'Callback', @A_value_Callback, 'CreateFcn', @A_value_CreateFcn);
    
    % Dynamically adding a static test field for Frequency (Label)
    handles.f_text(i) = uicontrol('parent', handles.uipanel3, 'style',...
        'text', 'string', sprintf('f%d', i), 'position', ...
        [5, 220 - 40*(i-1), 44, 19], 'FontSize', 10);
    
    % Dynamically adding a frequency slider
    handles.f_slider(i) = uicontrol('parent', handles.uipanel3, 'style',... 
        'slider','position', [49, 221 - 40*(i-1), 207, 18], 'Value', 1,...
        'min', 1, 'max', 256, 'SliderStep', [1/255, 0.1], 'Value', 1,...
        'Callback', @f_slider_Callback, 'CreateFcn', @f_slider_CreateFcn);
    
    % Dynamically adding a static text field for frequency (value)
    handles.f_value(i) = uicontrol('parent', handles.uipanel3, 'style',...
        'text', 'string', '1', 'position', [269, 223 - 40*(i-1), 52, 14],...
        'FontSize', 10);
    
    % Making all but the first fields invisible
    if(i ~= 1)
        handles.A_text(i).Visible = 'Off';
        handles.A_value(i).Visible = 'Off'; 
        handles.f_text(i).Visible = 'Off';
        handles.f_slider(i).Visible = 'Off';
        handles.f_value(i).Visible = 'Off';
    end
end

guidata(hObject, handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% NUMBER OF SINUSOIDAL INPUTS: K

% --- Executes on slider movement.
function k_slider_Callback(hObject, eventdata, handles)

handles = A_value_Callback(hObject, eventdata, handles);
handles = f_slider_Callback(hObject, eventdata, handles);

k = round(get(handles.k_slider, 'Value'));
set(handles.k_value, 'String', k);

handles.k_old = handles.k;
handles.k = k;

% Dynamically making fields visible if the slider increases
if(handles.k > handles.k_old)
    for i = handles.k_old + 1 : handles.k
        handles.A_text(i).Visible = 'On';
        handles.A_value(i).Visible = 'On';
        handles.f_text(i).Visible = 'On';
        handles.f_slider(i).Visible = 'On';
        handles.f_value(i).Visible = 'On';
    end
end

% Dynamically hiding fields if the slider decreases
if((handles.k < handles.k_old))
    for i = handles.k + 1 : handles.k_old
        handles.A_text(i).Visible = 'Off';
        handles.A_value(i).Visible = 'Off'; 
        handles.f_text(i).Visible = 'Off';
        handles.f_slider(i).Visible = 'Off';
        handles.f_value(i).Visible = 'Off';
    end
end

guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function k_slider_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% Storing the current and old value of k to edit the text fields dynamically
handles.k = 1;
handles.k_old = 1;
guidata(hObject, handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ORDER OF MOVING AVERAGE FILTER: M

% --- Executes on slider movement.
function M_slider_Callback(hObject, eventdata, handles)

M = round(get(handles.M_slider, 'Value'));
set(handles.M_value, 'String', M);
handles.M = M;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function M_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to M_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% Default value of M = 1
handles.M = 1;
guidata(hObject, handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% AMPLITUDES

function handles = A_value_Callback(hObject, eventdata, handles)

handles = guidata(hObject);

% Setting the size of A
A = zeros(1, handles.k);

for i = 1:handles.k
    A(i) =  str2double(get(handles.A_value(i), 'String'));
end

handles.A = A;
guidata(hObject, handles);

function A_value_CreateFcn(hObject, eventdata, handles)

handles = guidata(hObject);
handles.A = ones(1, handles.k);
guidata(hObject, handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% FREQUENCIES

function handles = f_slider_Callback(hObject, eventdata, handles)

handles = guidata(hObject);

% Setting the size of f
f = zeros(1, handles.k);

for i = 1:handles.k
    f(i) = round(get(handles.f_slider(i), 'Value'));
    set(handles.f_value(i), 'String', f(i));
end

handles.f = f;
guidata(hObject, handles);

function f_slider_CreateFcn(hObject, eventdata, handles)

handles = guidata(hObject);
handles.f = ones(1, handles.k);
guidata(hObject, handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
% RUN

% --- Executes on button press in run.
function run_Callback(hObject, eventdata, handles)

handles.run.Value = 0;

% Complete and total reset of the axes
cla reset;

% enabling all radio buttons
set(handles.time_domain_button, 'Value', 1, 'Enable', 'On'); 
set(handles.frequency_domain_button, 'Value', 0, 'Enable', 'On');
set(handles.filter_button, 'Value', 0, 'Enable', 'On');

%-------------------------------%

% Necessary in case amplitude & frequency callbacks are not called.
% i.e if the user leaves amplitude & frequency as the default and does not 
% change the value in the text box

handles = A_value_Callback(hObject, eventdata, handles);
handles = f_slider_Callback(hObject, eventdata, handles);
handles = guidata(hObject);

%-------------------------------%

fs = 512;                   % Sampling frequency
N = 512;                    % FFT size
t = 0 : 1/fs : 2-1/fs;   

%-------------------------------%
% TIME DOMAIN
%-------------------------------%

% Obtaining the input signal
x = zeros(1,length(t));
for i = 1:handles.k
    x = x + handles.A(i)*sin(2*pi* handles.f(i) .* t);
end

% Adding noise to the input signal if option is selected
if(get(handles.noise_checkbox, 'Value'))
    noise = randn(1, length(t));
    x = x + noise;
end

handles.t = t;
handles.x = x;

%-------------------------------%

% Obtaining the filter
num = ones(1, handles.M);
den = handles.M.*[1, zeros(1, handles.M-1)];
[H,w] = freqz(num, den, N);
mag_H = abs(H);
f_filter = (w./pi).*N/2; 

handles.num = num;
handles.den = den;
handles.f_filter = f_filter;
handles.mag_H = mag_H;
handles.mag_H_dB = mag2db(mag_H);

%-------------------------------%

% Obtaining the output signal
y = filter(num, den, x);

handles.y = y;

%-------------------------------%
% FREQUENCY DOMAIN
%-------------------------------%

% Obtaining the frequency responce of the input signal
f_io = 0:(N/2)-1;       % Raw index for FFT plot
df = fs/N;              % Frequency resolution
f_io = df.*f_io;        % x-axis frequencies
X = fft(x, N);
X = X(1:N/2);           % Taking only +ve frequencies
mag_X = abs(X) .* 2/N;  % Magnitude normalization

handles.f_io = f_io;
handles.mag_X = mag_X;

%-------------------------------%

% Obtaining the frequency responce of the output signal
Y = fft(y, N);
Y = Y(1:N/2);
mag_Y = abs(Y) .* 2/N;

handles.mag_Y = mag_Y;

%-------------------------------%

% Calling the time domain callback since time domain is the default
% selected radio button
handles = time_domain_button_Callback(hObject, eventdata, handles);
guidata(hObject, handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% TIME DOMAIN PLOTS

% --- Executes on button press in time_domain_button.
function handles = time_domain_button_Callback(hObject, eventdata, handles)

% Complete and total reset of the axes
cla reset;

% disabling relevant checkboxes
set(handles.td_input_signal_checkbox, 'Value', 0, 'Enable', 'On');
set(handles.td_output_signal_checkbox, 'Value', 0, 'Enable', 'On');

set(handles.fd_input_signal_checkbox, 'Value', 0, 'Enable', 'Off');
set(handles.fd_output_signal_checkbox, 'Value', 0, 'Enable', 'Off');

set(handles.magnitude_responce_button, 'Value', 0, 'Enable', 'Off');
set(handles.dB_checkbox, 'Value', 0, 'Enable', 'Off');
set(handles.pole_zero_button, 'Value', 0, 'Enable', 'Off');

% Plotting input signal in the time domain
handles.p1 = plot(handles.axes1,handles.t, handles.x);
grid on;
hold on;
title('Signal in continuous time domain'); 
xlabel('t = nT_s'); 

% Plotting output signal in the time domain
handles.p2 = plot(handles.axes1, handles.t,handles.y, '--');
hold off;

% Making plots invisible
set(handles.p1, 'Visible', 'off');
set(handles.p2, 'Visible', 'off');

legend('Input signal', 'Output signal');

guidata(hObject, handles);

% --- Executes on button press in td_input_signal_checkbox.

function td_input_signal_checkbox_Callback(hObject, eventdata, handles)

% Plotting time domain input signal
if(get(handles.td_input_signal_checkbox, 'Value'))
    ylabel('x[n]');
    set(handles.p1, 'Visible', 'on');
else
    set(handles.p1, 'Visible', 'off');
end

guidata(hObject, handles);

% --- Executes on button press in td_output_signal_checkbox.
function td_output_signal_checkbox_Callback(hObject, eventdata, handles)

if(get(handles.td_output_signal_checkbox, 'Value'))
    ylabel('y[n]');
    set(handles.p2, 'Visible', 'on');
else
    set(handles.p2, 'Visible', 'off');
end

guidata(hObject, handles);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% FREQUENCY DOMAIN PLOTS

% --- Executes on button press in frequency_domain_button.
function frequency_domain_button_Callback(hObject, eventdata, handles)

cla reset;

% disabling relevant checkboxes
set(handles.td_input_signal_checkbox, 'Value', 0, 'Enable', 'Off');
set(handles.td_output_signal_checkbox, 'Value', 0, 'Enable', 'Off');

set(handles.fd_input_signal_checkbox, 'Value', 0, 'Enable', 'On');
set(handles.fd_output_signal_checkbox, 'Value', 0, 'Enable', 'On');

set(handles.magnitude_responce_button, 'Value', 0, 'Enable', 'Off');
set(handles.dB_checkbox, 'Value', 0, 'Enable', 'Off');
set(handles.pole_zero_button, 'Value', 0, 'Enable', 'Off');

% Plotting input signal in the frequency domain
handles.p3 = stem(handles.axes1, handles.f_io,handles.mag_X);
grid on;
hold on;
title('Signal in frequency domain'); 
xlabel('Frequency [Hz]'); 
ylabel('Magnitude');

% Plotting output signal in the frequency domain
handles.p4 = stem(handles.axes1, handles.f_io,handles.mag_Y, '--');
hold off;

set(handles.p3, 'Visible', 'off');
set(handles.p4, 'Visible', 'off');

legend('Input signal', 'Output signal');

guidata(hObject, handles);

% --- Executes on button press in fd_input_signal_checkbox.
function fd_input_signal_checkbox_Callback(hObject, eventdata, handles)

% Plotting frequency domain input signal
if(get(handles.fd_input_signal_checkbox, 'Value'))
    set(handles.p3, 'Visible', 'On');
else
    set(handles.p3, 'Visible', 'Off');
end

guidata(hObject, handles);


% --- Executes on button press in fd_output_signal_checkbox.
function fd_output_signal_checkbox_Callback(hObject, eventdata, handles)

% Plotting frequency domain output signal
if(get(handles.fd_output_signal_checkbox, 'Value'))
     set(handles.p4, 'Visible', 'On');
else
    set(handles.p4, 'Visible', 'Off');
end

guidata(hObject, handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% FILTER PLOTS

% --- Executes on button press in filter_button.
function filter_button_Callback(hObject, eventdata, handles)

cla reset;

% disabling relevant checkboxes
set(handles.td_input_signal_checkbox, 'Value', 0, 'Enable', 'Off');
set(handles.td_output_signal_checkbox, 'Value', 0, 'Enable', 'Off');

set(handles.fd_input_signal_checkbox, 'Value', 0, 'Enable', 'Off');
set(handles.fd_output_signal_checkbox, 'Value', 0, 'Enable', 'Off');

set(handles.magnitude_responce_button, 'Value', 0, 'Enable', 'On');
set(handles.dB_checkbox, 'Value', 0, 'Enable', 'Off');
set(handles.pole_zero_button, 'Value', 0, 'Enable', 'On');

guidata(hObject, handles);

% --- Executes on button press in magnitude_responce_button.
function magnitude_responce_button_Callback(hObject, eventdata, handles)

% Plotting magnitude responce of the filter
handles.p5 = plot(handles.axes1, handles.f_filter,handles.mag_H);
grid on;
hold on;
title('Single sided magnitude spectrum'); 
xlabel('Frequency [Hz]'); 
ylabel('Magnitude');

% Plotting magnitude responce of the filter in dB
handles.p6 = plot(handles.axes1, handles.f_filter,handles.mag_H_dB);
hold off;

set(handles.p5, 'Visible', 'on');
set(handles.p6, 'Visible', 'off');

legend('Magnitude responce', 'Magnitude responce (dB)');

% Enabling the checkbox for dB scale
set(handles.dB_checkbox, 'Value', 0, 'Enable', 'On');

guidata(hObject, handles);

% --- Executes on button press in dB_checkbox.
function dB_checkbox_Callback(hObject, eventdata, handles)

% Plotting single sided magnitude spectrum (in dB) of the filter
if(get(handles.dB_checkbox, 'Value'))
    ylabel('Magnitude (dB)');
    set(handles.p5, 'Visible', 'Off');
    set(handles.p6, 'Visible', 'On');
else
    ylabel('Magnitude');
    set(handles.p5, 'Visible', 'On');
    set(handles.p6, 'Visible', 'Off');
end

guidata(hObject, handles);


% --- Executes on button press in pole_zero_button.
function pole_zero_button_Callback(hObject, eventdata, handles)

% Disabling the checkbox for dB scale
set(handles.dB_checkbox, 'Value', 0, 'Enable', 'Off');

handles.p7 = zplane(handles.num, handles.den);
title('Pole-zero plot');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ADDITIONAL TOOLS

% --- Executes on button press in reset.
function noise_checkbox_Callback(hObject, eventdata, handles)


% --------------------------------------------------------------------
function uipushtool1_ClickedCallback(hObject, eventdata, handles)
% Saving the current plot as an image

frame = getframe(handles.axes1);
image = frame2im(frame);
imwrite(image, 'output.jpg');

% Commented since export_fig is an external library
% export_fig(handles.uipanel5, 'output.jpg');

