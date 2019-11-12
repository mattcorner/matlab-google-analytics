classdef Visitor < matlab.mixin.SetGet & handle
    %VISITOR Visitor object
    
    properties (SetAccess = private)
        ClientID (1, 1) string % This anonymously identifies a particular device.
        UserID % This is intended to be a known identifier for a user provided by the site owner/tracking library user. It must not itself be PII (personally identifiable information). (optional)
        ScreenResolution % Specifies the screen resolution.
        ScreenColors % Specifies the screen color depth.
        UserLanguage % Specifies the language.
        DataSource % Indicates the data source of the hit. In this case, operating system / matlab version is used.
    end % read-only properties
    
    methods
        
        function obj = Visitor(varargin)
            %VISITOR Class constructor
            
            % parse inputs
            p = inputParser;
            p.addParameter('UserID', string.empty, @isStringScalar);
            p.parse(varargin{:});
            
            % assign properties
            set(obj, p.Results);
            obj.ClientID = obj.getClientID;
            obj.ScreenResolution = obj.getScreenResolution;
            obj.ScreenColors = get(0, 'ScreenDepth') + "-bits";
            obj.UserLanguage = string(get(0, 'Language'));
            obj.DataSource =  obj.getOS + " / " + obj.getMatlab;
            
        end % Visitor
        
    end % structors
    
    methods
        
        function str = string(obj)
            %STRING Convert hit to query parameters string
            
            % convert to struct using measurement protocol query names
            s.cid = obj.ClientID;
            if ~isempty(obj.UserID)
                s.uid = obj.UserID;
            end % if
            s.sr = obj.ScreenResolution;
            s.sd = obj.ScreenColors;
            s.ul = obj.UserLanguage;
            s.ds = obj.DataSource;
            
            % make use of matlabs query parameter to convert to a formatted
            % string
            q = matlab.net.QueryParameter(s);
            str = q.string;
            
        end % string
        
    end % public methods
    
    methods (Static, Access = private)
        
        function cid = getClientID
            %GETCLIENTID Returns client id for current machine.
            %   This client id persists across matlab instances, and is unique to a
            %   machine. It is stored in matlabprefs.mat.
            
            % return from preference if it exists, otherwise create a new uuid and save
            % it
            cid = getpref('GoogleAnalytics', 'ClientID', mga.util.uuid);
            cid = string(cid); % getpref returns a char when it was set as string?
            
        end % getClientID
        
        function res = getScreenResolution
            %GETSCREENRESOLUTION Returns screen resoltion as a string
            
            % get screen size array and convert to string
            sz = get(0, 'ScreenSize');
            res = sz(3) + "x" + sz(4);
            
        end % getScreenResolution
        
        function os = getOS
            %GETOS Returns operating system and version
            
            % get name and version and convert to string
            [name, version] = mga.util.detectOS;
            os = name + " (" + strjoin(string(version), ".") + ")";
            
            % capitalise
            os{1}(1) = upper(os{1}(1));
            
        end % getOS
        
        function m = getMatlab
            %GETMATLAB Returns matlab version
            
            v = ver('matlab');
            m = extractBetween(v.Release, "(", ")");
            
        end % getMatlab
        
    end % static private methods
    
end % classdef