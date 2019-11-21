classdef PageviewTests < matlab.unittest.TestCase
    %PAGEVIEWTESTS Tests for mga.hit.Pageview
    
    methods (Test, TestTags = "Unit")
        
        function canConstructWithRequiredInputs(testCase)
            %CANCONSTRUCTWITHREQUIREDINPUTS Tests that we can construct
            %with the required inputs
            
            % construct warning free
            path = "/this/is/a/path";
            pv = testCase.verifyWarningFree(@() mga.hit.Pageview(path));
            
            % verify properties
            testCase.verifyEqual(pv.Path, path);
            
        end % canConstructWithRequiredInputs
        
        function canConstructWithOptionalInputs(testCase)
            %CANCONSTRUCTWITHOPTIONALINPUTS Tests that we can construct
            %with all inputs
            
            % construct warning free
            path = "/this/is/a/path";
            title = "This is a random title";
            ni = true;
            pvpairs = {'Title', title, ...
                'NonInteraction', ni};
            pv = testCase.verifyWarningFree(@() mga.hit.Pageview(path, pvpairs{:}));
            
            % verify properties
            testCase.verifyEqual(pv.Path, path);
            testCase.verifyEqual(pv.Title, title);
            testCase.verifyEqual(pv.NonInteraction, ni);
            
        end % canConstructWithOptionalInputs
        
        function getErrorOnOversizePath(testCase)
            %GETERRORONOVERSIZEPATH Test that we honour the google byte
            %size limit for this parameter
            
            % verify error on construction
            path = string(repmat('a', 1, 2049));
            testCase.verifyError(@() mga.hit.Pageview(path), 'Hit:maxLengthExceeded');
            
        end % getErrorOnOversizePath
        
        function getErrorOnInvalidPath(testCase)
            %GETERRORONINVALIDPATH Tests that a path must start with '/'
            
            % verify error on construction
            path = "this/didnt/start/with/forward/slash";
            testCase.verifyError(@() mga.hit.Pageview(path), 'Pageview:invalidFirstChar');
            
        end % getErrorOnInvalidPath
        
        function getErrorOnOversizeTitle(testCase)
            %GETERRORONOVERSIZETITLE Test that we honour the google byte
            %size limit for this parameter
            
            % verify error on construction
            path = "/this/is/a/path";
            title = string(repmat('a', 1, 1501));
            testCase.verifyError(@() mga.hit.Pageview(path, 'Title', title), ...
                'Hit:maxLengthExceeded');
            
        end % getErrorOnOversizeTitle
        
        function queryParametersForRequiredInputs(testCase)
            %QUERYPARAMETERSFORREQUIREDINPUTS Tests that we can return an
            %array of QueryParameters for required inputs
            
            % construct pageview
            path = "/this/is/a/path";
            pv = mga.hit.Pageview(path);
            
            % verify warning free method call
            qp = testCase.verifyWarningFree(@() pv.queryParameters);
            
            % verify array of query paramters
            testCase.verifyClass(qp, 'matlab.net.QueryParameter');
            testCase.verifySize(qp, [1 2]);
            
            % verify names
            import matlab.unittest.constraints.*
            testCase.verifyThat([qp.Name], IsSameSetAs(["t", "dp"]));
            
        end % queryParametersForRequiredInputs
        
        function queryParametersForOptionalInputs(testCase)
            %QUERYPARAMETERSFOROPTIONALINPUTS Tests that we can return an
            %array of QueryParameters for all inputs
            
            % construct pageview
            path = "/this/is/a/path";
            title = "This is a random title";
            ni = true;
            pvpairs = {'Title', title, ...
                'NonInteraction', ni};
            pv = mga.hit.Pageview(path, pvpairs{:});
            
            % verify warning free method call
            qp = testCase.verifyWarningFree(@() pv.queryParameters);
            
            % verify array of query paramters
            testCase.verifyClass(qp, 'matlab.net.QueryParameter');
            testCase.verifySize(qp, [1 4]);
            
            % verify names
            import matlab.unittest.constraints.*
            testCase.verifyThat([qp.Name], IsSameSetAs(["t", "dp", "dt", "ni"]));
            
        end % queryParametersForOptionalInputs
        
    end % unit test methods
    
end % classdef