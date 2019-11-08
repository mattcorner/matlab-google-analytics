classdef Tracker < matlab.mixin.SetGet
    %TRACKER Singleton tracker object
    
    properties (Constant)
        ProtocolVersion = 1 % The Protocol version. The current value is '1'. This will only change when there are changes made that are not backwards compatible.
    end % constant properties
    
    properties (SetAccess = private)
        TrackingID % The tracking ID / web property ID. The format is UA-XXXX-Y. All collected data is associated by this ID.
        Hostname % Specifies the hostname from which content was hosted.
    end % read-only properties
    
    methods
        
        function obj = Tracker(varargin)
            %TRACKER Class constructor
            
            % parse inputs
            p = inputParser;
            p.addRequired('TrackingID', @isStringScalar);
            p.addRequired('Hostname', @isStringScalar);
            p.parse(varargin{:});
            
            % assign inputs
            set(obj, p.Results);
            
        end % Tracker
        
    end % structors
    
    methods (Static)
        
        function obj = getInstance
            %GETINSTANCE Returns singleton tracker object
            
            % either get stored singleton, or construct new
            persistent uniqueInstance
            if isempty(uniqueInstance)
                obj = mga.Tracker;
                uniqueInstance = obj;
            else
                obj = uniqueInstance;
            end % if else
            
        end % getInstance
        
    end % static methods
    
end % Tracker