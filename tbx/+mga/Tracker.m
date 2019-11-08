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
            persistent p
            if isempty(p)
                p = inputParser;
                p.addRequired('TrackingID', @isStringScalar); % TODO: Validate according to google requirements
                p.addRequired('Hostname', @isStringScalar); % TODO: Validate is valid hostname
            end % if
            p.parse(varargin{:});
            
            % assign inputs
            set(obj, p.Results);
            
        end % Tracker
        
    end % structors
    
end % Tracker