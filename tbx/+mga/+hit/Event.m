classdef Event < mga.hit.Hit
    %EVENT Event hit type
    %
    %   e = Event(category, action) constructs event with required
    %   properties.
    %
    %   e = Event(..., 'Name', Value) constructs event with optional
    %   properties:
    %       - Label
    %       - Value
    
    properties (Constant)
        Type = mga.hit.HitType.event % The type of hit.
    end % constant properties
    
    properties (SetAccess = private, AbortSet = true)
        Category (1, 1) string % Specifies the event category. Must not be empty.
        Action (1, 1) string % Specifies the event action. Must not be empty.
        Label string % Specifies the event label.
        Value % Specifies the event value. Values must be non-negative.
    end % read-only properties
    
    methods
        
        function obj = Event(varargin)
            %EVENT Class constructor
            
            % parse inputs
            persistent p
            if isempty(p)
                p = inputParser;
                p.KeepUnmatched = true;
                p.addRequired('Category', @isStringScalar); % TODO: Validate is <= 150 bytes
                p.addRequired('Action', @isStringScalar); %TODO: Validate is <= 500 bytes
                p.addParameter('Label', string.empty, @isStringScalar); %TODO: Validatre is <= 500 bytes
                p.addParameter('Value', double.empty, @(v) isnumeric(v) && issalar(v) && isgt(v, 0));
            end % if
            p.parse(varargin{:});
            
            % call superclass constructor
            obj = obj@mga.hit.Hit(p.Unmatched);
            
            % set values
            set(obj, p.Results);
            
        end % Event
        
    end % structors
    
    methods
        
        function qp = queryParameters(obj)
            %QUERYPARAMETERS Convert hit to query parameter objects
            
            % convert to struct using measurement protocol query names
            s.t = obj.Type.string;
            s.ec = obj.Category;
            s.ea = obj.Action;
            if ~isempty(obj.Label)
                s.el = obj.Label;
            end % if
            if ~isempty(obj.Value)
                s.ev = obj.Value;
            end % if
            
            % convert to query parameters
            qp = matlab.net.QueryParameter(s);
            
        end % queryParameters
        
    end % public methods
    
end % classdef