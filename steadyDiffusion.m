function varargout = steadyDiffusion(varargin)
% STEADYDIFFUSION MATLAB code for steadyDiffusion.fig
%      Group: Ashwin, Jerik, Remil, Sunil.
%
%      To open the GUI, run this file please. This requires all other
%      dependent functions: RODTEMPERATURE, TDMA and steadyDiffusion.fig to
%      be in the same folder.
%      STEADYDIFFUSION, by itself, creates a new STEADYDIFFUSION or raises the existing
%      singleton*.
%
%      H = STEADYDIFFUSION returns the handle to a new STEADYDIFFUSION or the handle to
%      the existing singleton*.
%
%      STEADYDIFFUSION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STEADYDIFFUSION.M with the given input arguments.
%
%      STEADYDIFFUSION('Property','Value',...) creates a new STEADYDIFFUSION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before steadyDiffusion_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to steadyDiffusion_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%      
%      STEADYDIFFUSION was created as part of the submission for assignment
%      3. This is GUI for RODTEMPERATURE: the function that solution to the
%      diffusion equation using finite volume method on a uniformly heat 
%      rod of uniform conductivity and cross sectional area.

% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help steadyDiffusion

% Last Modified by GUIDE v2.5 10-Mar-2017 18:43:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @steadyDiffusion_OpeningFcn, ...
                   'gui_OutputFcn',  @steadyDiffusion_OutputFcn, ...
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


% --- Executes just before steadyDiffusion is made visible.
function steadyDiffusion_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to steadyDiffusion (see VARARGIN)

% Choose default command line output for steadyDiffusion
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes steadyDiffusion wait for user response (see UIRESUME)
% uiwait(handles.figure1);

%This is a function tht updates the graph on the GUI. Everytime a slider is
%moved, this function is called.
function updateGraph(handles)
% Get parameters
N = floor(get(handles.NSlider,'Value'));
length = get(handles.LSlider,'Value');
area = get(handles.ASlider,'Value');
tA = get(handles.t_aSlider,'Value');
tB = get(handles.t_bSlider,'Value');
k = get(handles.kSlider,'Value');
q = get(handles.qSlider,'Value');

% Compute the solution:
[x,temp,exact] = rodTemperature(length,area,tA,tB,k,N,q);
% Plot:
plot(handles.axes1, x,temp,'--','LineWidth',2);
hold on
plot(handles.axes1,x,exact,':','LineWidth',2);
title({strcat('length = ',num2str(length),' area = ',num2str(area));
    strcat('T_A = ',num2str(tA), ' T_B = ',num2str(tB), ' q = ', num2str(q));
    strcat('Number of inner nodes = ',num2str(N),' Conductivity = ',num2str(k))});
xlabel('Position on rod from left end (m)');
ylabel('Temperature (K)');
legend('Solution from FV','Analytical solution');
hold off


% --- Outputs from this function are returned to the command line.
function varargout = steadyDiffusion_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function NSlider_Callback(hObject, eventdata, handles)
% hObject    handle to NSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
updateGraph(handles);

% --- Executes during object creation, after setting all properties.
function NSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function kSlider_Callback(hObject, eventdata, handles)
% hObject    handle to kSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
updateGraph(handles);

% --- Executes during object creation, after setting all properties.
function kSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to kSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function t_bSlider_Callback(hObject, eventdata, handles)
% hObject    handle to t_bSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
updateGraph(handles);

% --- Executes during object creation, after setting all properties.
function t_bSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to t_bSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function t_aSlider_Callback(hObject, eventdata, handles)
% hObject    handle to t_aSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
updateGraph(handles);

% --- Executes during object creation, after setting all properties.
function t_aSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to t_aSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function LSlider_Callback(hObject, eventdata, handles)
% hObject    handle to LSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
updateGraph(handles);

% --- Executes during object creation, after setting all properties.
function LSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function ASlider_Callback(hObject, eventdata, handles)
% hObject    handle to ASlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
updateGraph(handles);

% --- Executes during object creation, after setting all properties.
function ASlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ASlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function qSlider_Callback(hObject, eventdata, handles)
% hObject    handle to qSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
updateGraph(handles);

% --- Executes during object creation, after setting all properties.
function qSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to qSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
