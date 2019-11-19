classdef Pageview < mga.hit.Hit
    %PAGEVIEW Pageview hit type
    %
    %   p = Pageview(path)
    %
    %   p = Pageview(..., 'Name', Value) constructs pageviews with optional
    %   properties:
    %       - Title
    
    properties (Constant)
        Type = mga.hit.HitType.pageview % The type of hit.
    end % constant properties
    
    properties (SetAccess = private, AbortSet = true)
        Path (1, 1) string % The path portion of the page URL.
        Title string % The title of the page / document.
    end % read-only properties
    
    methods
        
        function obj = Pageview(varargin)
            %PAGEVIEW Class constructor
            
            % parse inputs
            persistent p
            if isempty(p)
                p = inputParser;
                p.KeepUnmatched = true;
                p.addRequired('Path', @isStringScalar) % TODO: Validate string begins with /
                p.addParameter('Title', string.empty, @isStringScalar);
            end % if
            p.parse(varargin{:});
            
            % call superclass construtor
            obj = obj@mga.hit.Hit(p.Unmatched);
            
            % set values
            set(obj, p.Results);
            
        end % Pageview
        
    end % structors
    
    methods
        
        function qp = queryParameters(obj)
            %QUERYPARAMETERS Convert hit to query parameters objects
            
            % convert to struct using measurement protocol query names
            s.t = obj.Type.string;
            s.dp = obj.Path;
            if ~isempty(obj.Title)
                s.dt = obj.Title;
            end % if
            
            % convert to query parameters
            qp = matlab.net.QueryParameter(s);
            
        end % queryParameters
        
    end % public methods
    
end % classdef