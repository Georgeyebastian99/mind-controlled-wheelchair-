clc;
clear variable;
close all;

%Comport Selection
portnum1 = 3;
%COM Port #
comPortName1 = sprintf('\\\\.\\COM%d', portnum1);
% Baud rate for use with TG_Connect() and TG_SetBaudrate().
TG_BAUD_115200 = 115200;
% Data format for use with TG_Connect() and TG_SetDataFormat().
TG_STREAM_PACKETS = 0;

port = 'COM6';
board = 'Uno';
a = arduino(port,board);

%load thinkgear dll
loadlibrary('thinkgear64.dll');
%To display in Command Window
fprintf('Thinkgear.dll loaded\n');
%get dll version
dllVersion = calllib('thinkgear64', 'TG_GetDriverVersion');
%To display in command window
fprintf('ThinkGear DLL version: %d\n', dllVersion );
% Get a connection ID handle to ThinkGear
connectionId1 = calllib('thinkgear64', 'TG_GetNewConnectionId');


if ( connectionId1 < 0 )
calllib('thinkgear64', 'TG_FreeConnection', connectionId1 );
error('ERROR: TG_GetNewConnectionId() returned %d.\n', connectionId1);
end
% Set/open stream (raw bytes) log file for connection
errCode1 = calllib('thinkgear64', 'TG_SetStreamLog', connectionId1, 'streamLog.txt' );
if( errCode1 < 0 )
   calllib('thinkgear64', 'TG_FreeConnection', connectionId1 );
   error('ERROR: TG_SetStreamLog() returned %d.\n', errCode1);
end
% Set/open data (ThinkGear values) log file for connection
errCode2 = calllib('thinkgear64', 'TG_SetDataLog', connectionId1, 'dataLog.txt' );
if( errCode2 < 0 )
    calllib('thinkgear64', 'TG_FreeConnection', connectionId1 );
    error('ERROR: TG_SetDataLog() returned %d.\n', errCode2);
end
% Attempt to connect the connection ID handle to serial port "COM3"
errCode3 = calllib('thinkgear64', 'TG_Connect', connectionId1,comPortName1,TG_BAUD_115200,TG_STREAM_PACKETS );
if ( errCode3 < 0 )
    calllib('thinkgear64', 'TG_FreeConnection', connectionId1 );
    error('ERROR: TG_Connect() returned %d.\n', errCode3);
end

while(errCode3 == 0)
    check_poor_connection(connectionId1)
end
 
%Release the comm port
calllib('thinkgear64', 'TG_FreeConnection', connectionId1 );

 function BSCW(RC, RA, LA, LC)
    RIGHT_CLOCK = 'D2';
    RIGHT_ANTI = 'D4';
    LEFT_ANTI = 'D6';
    LEFT_CLOCK = 'D8';
    a.writeDigitalPin(RIGHT_CLOCK,RC)
    a.writeDigitalPin(RIGHT_ANTI,RA)
    a.writeDigitalPin(LEFT_ANTI,LA)
    a.writeDigitalPin(LEFT_CLOCK,LC)
 end

 function check_poor_connection(connectionId1)
     while(poor_connection(connectionId1, 10)==1)
        while(poor_connection(connectionId1, 10)==1)
            if(meditation(connectionId1) > 50)
                decleration(connectionId1)
            else
                check_poor_connection(connectionId1)
            end
        end
    end
 end
 
 function decleration(connectionId1)
    disp('direction or movement');
    if(blink(connectionId1,2)==2)
        movement(connectionId1)
    else
        if(blink(connectionId1,2)==1)
            direction(connectionId1)
        else
            check_poor_connection(connectionId1)
        end
    end
 end
 
 function movement(connectionId1)
    disp('forward or backward');
     if(blink(connectionId1,1)==1)
        if(attention(connectionId1) > 50)
            disp('FORWARD');
            BSCW(1, 0, 1, 0);
            if(poor_connection(connectionId1, 100)==1)
                disp("STOP");
                BSCW(0, 0, 0, 0);
            end
        decleration(connectionId1)
        end
     else
        if(attention(connectionId1) > 50)
            disp("BACKWARD");
            BSCW(0, 1, 0, 1);
            if(poor_connection(connectionId1, 100)==1)
                disp("STOP");
                BSCW(0, 0, 0, 0);
            end
        decleration(connectionId1)
        end
     end
 end
 
 function direction(connectionId1)
    disp('left or right');
    if(blink(connectionId1,1)==1)
        if(attention(connectionId1) > 50)
            disp("RIGHT");
            BSCW(0, 0, 1, 0);
            if(poor_connection(connectionId1, 100)==1)
                disp("STOP");
                BSCW(0, 0, 0, 0);
            end
        decleration(connectionId1)
        end
     else
        if(attention(connectionId1) > 50)
            disp("LEFT");
            BSCW(1, 0, 0, 0);
            if(poor_connection(connectionId1, 100)==1)
                disp("STOP");
                BSCW(0, 0, 0, 0);
            end
        decleration(connectionId1)
        end
     end
 end
 
 
