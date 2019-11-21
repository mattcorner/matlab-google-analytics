classdef VisitorTests < matlab.unittest.TestCase
    %VISITORTESTS Tests for mga.Visitor
    
    properties (Constant)
        SampleAppVersion = "1.2.3" % Sample app version
    end % constant properties
    
    properties
        ExpectedScreenResolution % Expected screen resolution
        ExpectedScreenColors % Expected screen depth
        ExpectedUserLanguage % Expected user language
        ExpectedUserAgent % Expected user agent
        ExpectedDataSource % Expected data source
    end % public properties
    
    methods (TestClassSetup)
        
        function getExpectedPropertyValues(testCase)
            %GETEXPECTEDPROPERTYVALUES Get and store the expected property
            %values that relate to the system
            
            % screen resolution
            sz = get(0, 'ScreenSize');
            testCase.ExpectedScreenResolution = sz(3) + "x" + sz(4);
            
            % screen colors
            testCase.ExpectedScreenColors = get(0, 'ScreenDepth') + "-bits";
            
            % user language
            testCase.ExpectedUserLanguage = string(get(0, 'Language'));
            
            % user agent
            v = ver('matlab');
            ml = extractBetween(v.Release, "(", ")");
            app = testCase.SampleAppVersion;
            [name, version] = mga.util.detectOS;
            os = name + " " + strjoin(string(version), ".");
            os{1}(1) = upper(os{1}(1));
            testCase.ExpectedUserAgent = ml + "/" + app + " (" + os + ")";
            
            % data source
            if isdeployed
                ds = "deployed";
            else
                ds = "matlab";
            end % if else
            testCase.ExpectedDataSource = ds;
            
        end % getExpectedPropertyValues
        
    end % test class setup methods
    
    methods (Test, TestTags = "Integration")
        
        function canConstructWithNoInputs(testCase)
            %CANCONSTRUCTWITHNOINPUTS Tests that we can construct a
            %visitors object with no inputs
            
            % verify warning free construction
            vis = testCase.verifyWarningFree(@() mga.Visitor);
            
            % verify properties
            testCase.verifyEqual(vis.ClientID, string(getpref('GoogleAnalytics', 'ClientID')));
            testCase.verifyEmpty(vis.UserID);
            testCase.verifyEqual(vis.ScreenResolution, testCase.ExpectedScreenResolution);
            testCase.verifyEqual(vis.ScreenColors, testCase.ExpectedScreenColors);
            testCase.verifyEqual(vis.UserLanguage, testCase.ExpectedUserLanguage);
            testCase.verifyEqual(vis.UserAgent, strrep(testCase.ExpectedUserAgent, "1.2.3", "unknown"));
            testCase.verifyEqual(vis.DataSource, testCase.ExpectedDataSource);
            
        end % canConstructWithNoInputs
        
        function canConstrucTWithAllInputs(testCase)
            
            % verify warning free construction
            uid = "SomethingUnique";
            av = testCase.SampleAppVersion;
            pvpairs = {'UserID', uid, ...
                'AppVersion', av};
            vis = testCase.verifyWarningFree(@() mga.Visitor(pvpairs{:}));
            
            % verify properties
            testCase.verifyEqual(vis.ClientID, string(getpref('GoogleAnalytics', 'ClientID')));
            testCase.verifyEqual(vis.UserID, uid);
            testCase.verifyEqual(vis.ScreenResolution, testCase.ExpectedScreenResolution);
            testCase.verifyEqual(vis.ScreenColors, testCase.ExpectedScreenColors);
            testCase.verifyEqual(vis.UserLanguage, testCase.ExpectedUserLanguage);
            testCase.verifyEqual(vis.UserAgent, testCase.ExpectedUserAgent);
            testCase.verifyEqual(vis.DataSource, testCase.ExpectedDataSource);
            
        end % canConstrucTWithAllInputs
        
        function queryParametersWithNoInputs(testCase)
            
            % construct visitor
            vis = mga.Visitor;
            
            % verify warning free method call
            qp = testCase.verifyWarningFree(@() vis.queryParameters);
            
            % verify array of query parameters
            testCase.verifyClass(qp, 'matlab.net.QueryParameter');
            testCase.verifySize(qp, [1 6]);
            
            % verify names
            import matlab.unittest.constraints.*
            testCase.verifyThat([qp.Name], IsSameSetAs(["cid", "sr", "sd", "ul", "ds", "ua"]));
            
        end % queryParametersWithNoInputs
        
        function queryParametersWithAllInputs(testCase)
            
            % construct visitor
            uid = "SomethingUnique";
            av = testCase.SampleAppVersion;
            pvpairs = {'UserID', uid, ...
                'AppVersion', av};
            vis = mga.Visitor(pvpairs{:});
            
            % verify warning free method call
            qp = testCase.verifyWarningFree(@() vis.queryParameters);
            
            % verify array of query parameters
            testCase.verifyClass(qp, 'matlab.net.QueryParameter');
            testCase.verifySize(qp, [1 7]);
            
            % verify names
            import matlab.unittest.constraints.*
            testCase.verifyThat([qp.Name], IsSameSetAs(["cid", "uid", "sr", "sd", "ul", "ds", "ua"]));
            
        end % queryParametersWithAllInputs
        
    end % integration test methods
    
end % classdef