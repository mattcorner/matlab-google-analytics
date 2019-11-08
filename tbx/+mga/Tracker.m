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
            
            % assign inputs
            set(obj, varargin{:});
            
        end % Tracker
        
    end % structors
    
    methods (Static)
        
        function obj = getInstance(varargin)
            %GETINSTANCE Returns singleton tracker object
            
            % parse inputs
            persistent p
            if isempty(p)
                p = inputParser;
                p.addRequired('TrackingID', @isStringScalar); % TODO: Validate according to google requirements
                p.addRequired('Hostname', @isStringScalar); % TODO: Validate is valid hostname
            end % if
            p.parse(varargin{:});
            
            % either get table of current trackers, or create new tracker
            % if no table exists
            persistent t
            if isempty(t)
                obj = mga.Tracker(p.Results);
                t = table(p.Results.TrackingID, p.Results.Hostname, obj, ...
                    'VariableNames', {'TrackingID', 'Hostname', 'Object'});
                return
            end % if
            
            % extract singleton from table, or create new tracker if it
            % doesnt exist
            idx = ismember(t.TrackingID, p.Results.TrackingID) & ...
                ismember(t.Hostname, p.Results.Hostname);
            if ~idx
                obj = mga.Tracker(p.Results);
                t = [t; table(p.Results.TrackingID, p.Results.Hostname, obj, ...
                    'VariableNames', {'TrackingID', 'Hostname', 'Object'})];
            else
                obj = t.Object(idx);
            end % if else
            
        end % getInstance
        
    end % static methods
    
end % Tracker