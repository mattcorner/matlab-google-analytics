classdef HitTypeTests < matlab.unittest.TestCase
    %HITTYPETESTS Tests for mga.hit.HitType
    
    properties (TestParameter)
        Type = {'pageview', 'screenview', 'event', 'transaction', 'item', ...
            'social', 'timing', 'exception'} % hit types supported by google
    end % test parameters
    
    methods (Test, TestTags = "Unit")
        
        function hasAllTypes(testCase, Type)
            %HASALLTYPES Tests that we can enumerate all supported hit
            %types
            
            ht = testCase.verifyWarningFree(@() mga.hit.HitType.(Type));
            testCase.verifyEqual(ht.char, Type);
            
        end % hasAllTypes
        
    end % unit test methods
    
end % classdef