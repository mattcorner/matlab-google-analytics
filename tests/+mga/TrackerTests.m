classdef TrackerTests < matlab.mock.TestCase
    %TRACKERTESTS Tests for mga.Tracker
    
    properties (Constant)
        SampleTrackingID = "UA-XXXXXXXXX-X" % Sample tracking id
        SampleHostname = "http://example.com" % Sample hostname
    end % constant properties
    
    methods (TestClassSetup)
        
        function mockUrlreadToReturnTrue(testCase)
            %MOCKURLREADTORETURNTRUE Mock urlread builtin function to
            %return true for duration of tests
            
            % using path shadowing
            import matlab.unittest.fixtures.*
            testCase.applyFixture(PathFixture(fullfile(mgaTestRoot, 'mocks', 'urlread', 'returnsTrue')));
            
        end % mockUrlreadToReturnTrue
        
    end % test class setup methods
    
    methods (Test, TestTags = "Unit")
        
        function canConstructWithRequiredInputs(testCase)
            %CANCONSTRUCTWITHREQUIREDINPUTS Tests that we can construct
            %tracker
            
            % construct warning free
            tid = testCase.SampleTrackingID;
            hn = testCase.SampleHostname;
            trck = testCase.verifyWarningFree(@() mga.Tracker(tid, hn));
            
            % verify properties
            testCase.verifyEqual(trck.TrackingID, tid);
            testCase.verifyEqual(trck.Hostname, hn);
            testCase.verifyEqual(trck.ProtocolVersion, 1);
            
        end % canConstructWithRequiredInputs
        
        function canGetUrlWithKnownQueryParameters(testCase)
            %CANGETURLWITHKNOWNQUERYPARAMETERS Tests that we can get the
            %url string using known query parameters
            
            % create query parameter
            qp = matlab.net.QueryParameter('Test', 123);
            
            % create tracker
            tid = testCase.SampleTrackingID;
            hn = testCase.SampleHostname;
            trck = mga.Tracker(tid, hn);
            
            % call method warning freee
            str = trck.uri(qp);
            
            % verify output
            testCase.verifyEqual(str, "https://www.google-analytics.com/collect?Test=123");
            
        end % canGetUrlWithKnownQueryParameters
        
        function canGetQueryParameters(testCase)
            %CANGETQUERYPARAMETERS Tests that we can get the query
            %parameters for a tracker
            
            % create tracker
            tid = testCase.SampleTrackingID;
            hn = testCase.SampleHostname;
            trck = mga.Tracker(tid, hn);
            
            % call method warning freee
            qp = trck.queryParameters;
            
            % verify query parameters
            testCase.verifyClass(qp, 'matlab.net.QueryParameter');
            testCase.verifySize(qp, [1 3]);
            import matlab.unittest.constraints.*
            testCase.verifyThat([qp.Name], IsSameSetAs(["v", "tid", "dh"]));
            
        end % canGetQueryParameter
        
        function canTrack(testCase)
            %CANTRACK Tests that we can track using mocks for visitor and
            %hit
            
            
        end % canTrack
        
    end % unit test methods
    
    methods (Test, TestTags = "Integration")
        
        function canTrackEvent(testCase)
            %CANTRACKEVENT Tests that we can track and event
            
        end % canTrackEvent
        
        function canTrackPageview(testCase)
            %CANTRACKPAGEVIEW Tests that we can track a pageview
            
        end % canTrackPageview
        
    end % integration test methods
    
end % TrackerTests