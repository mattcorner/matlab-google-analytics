classdef (Abstract) Hit < matlab.mixin.SetGet
    %HIT Superclass for hits
    
    properties (Abstract, Constant)
        Type % The type of hit. Must be one of 'pageview', 'screenview', 'event', 'transaction', 'item', 'social', 'exception', 'timing'.
    end % constant properties
    
    properties (SetAccess = private, AbortSet = true)
        NonInteraction (1, 1) logical = false % Specifies that a hit be considered non-interactive.
    end % read-only properties
    
    methods
        
        function obj = Hit(varargin)
            %HIT Class constructor
            
            % parse inputs
            persistent p
            if isempty(p)
                p = inputParser;
                p.addParameter('NonInteraction', false, @islogical);
            end % if
            p.parse(varargin{:});
            
            % assign values
            set(obj, p.Results);
            
        end % Hit
        
    end % structors
    
end % classdef