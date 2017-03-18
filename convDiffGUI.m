function varargout = convDiffGUI(varargin)
% CONVDIFFGUI MATLAB code for convDiffGUI.fig
%      Group: Ashwin, Jerik, Remil, Sunil.
%
%      To open the GUI, run this file please. This requires all other
%      dependent functions: CONVECTIONDIFFUSION, CONVDIFFCD, CONVDIFFPU and
%      convDiffGUI.fig to be in the same folder.
%      CONVDIFFGUI, by itself, creates a new CONVDIFFGUI or raises the existing
%      singleton*.
%
%      H = CONVDIFFGUI returns the handle to a new CONVDIFFGUI or the handle to
%      the existing singleton*.
%
%      CONVDIFFGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CONVDIFFGUI.M with the given input arguments.
%
%      CONVDIFFGUI('Property','Value',...) creates a new CONVDIFFGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before convDiffGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to convDiffGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%      
%      CONVDIFFGUI was created as part of the submission for assignment
%      3. This is GUI for RODTEMPERATURE: the function that solution to the
%      diffusion equation using finite volume method on a uniformly heat 
%      rod of uniform conductivity and cross sectional area.

% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help convDiffGUI

% Last Modified by GUIDE v2.5 18-Mar-2017 02:38:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @convDiffGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @convDiffGUI_OutputFcn, ...
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


% --- Executes just before convDiffGUI is made visible.
function convDiffGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to convDiffGUI (see VARARGIN)

% Choose default command line output for convDiffGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes convDiffGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);

function updateGraph(handles)

methodName = get(handles.methodMenu,'Value');

if methodName~=1
    % Get parameters
    N = floor(get(handles.NSlider,'Value'));
    phiA = get(handles.phiASlider,'Value');
    phiB = get(handles.phiBSlider,'Value');
    rho = get(handles.rhoSlider,'Value');
    u = get(handles.uSlider,'Value');
    gamma = get(handles.gammaSlider,'Value');
    
    % Compute the solution over [0,1] with N control volumes:
    dx = 1/N;
    x = linspace(dx,1-dx,N);
    x = cat(2,0,x,1);
    if methodName == 2
        method = 'cd';
        legendString = 'Central difference solution';
    elseif methodName == 3
        method = 'pu';
        legendString = 'Pure upwind solution';
    end
    
    [phi, exact] = convectionDiffusion(x,[phiA, phiB],u,rho,gamma,method);
    
    % Plot:
    plot(handles.axes1, x,phi,'--','LineWidth',2);
    hold on
    plot(handles.axes1,x,exact,':','LineWidth',2);
    title({strcat('rho = ',num2str(rho),' u = ',num2str(u));
        strcat('phi_A = ',num2str(phiA), ' phi_B = ',num2str(phiB));
        strcat('Number of inner nodes = ',num2str(N),' Gamma = ',num2str(gamma))});
    xlabel('Position (m)');
    ylabel('Phi');
    legend(legendString,'Analytical solution','Location','best');
    hold off
end


% --- Outputs from this function are returned to the command line.
function varargout = convDiffGUI_OutputFcn(hObject, eventdata, handles) 
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
function gammaSlider_Callback(hObject, eventdata, handles)
% hObject    handle to gammaSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
updateGraph(handles);

% --- Executes during object creation, after setting all properties.
function gammaSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gammaSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function phiBSlider_Callback(hObject, eventdata, handles)
% hObject    handle to phiBSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
updateGraph(handles);

% --- Executes during object creation, after setting all properties.
function phiBSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to phiBSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function phiASlider_Callback(hObject, eventdata, handles)
% hObject    handle to phiASlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
updateGraph(handles);

% --- Executes during object creation, after setting all properties.
function phiASlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to phiASlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function uSlider_Callback(hObject, eventdata, handles)
% hObject    handle to uSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
updateGraph(handles);

% --- Executes during object creation, after setting all properties.
function uSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function rhoSlider_Callback(hObject, eventdata, handles)
% hObject    handle to rhoSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
updateGraph(handles);

% --- Executes during object creation, after setting all properties.
function rhoSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rhoSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on selection change in methodMenu.
function methodMenu_Callback(hObject, eventdata, handles)
% hObject    handle to methodMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns methodMenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from methodMenu
updateGraph(handles);

% --- Executes during object creation, after setting all properties.
function methodMenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to methodMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
