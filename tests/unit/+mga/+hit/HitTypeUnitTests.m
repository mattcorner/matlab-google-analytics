classdef HitTypeUnitTests < matlab.unittest.TestCase
    %HITTYPEUNITTESTS Unit tests for mga.hit.HitType
    
    properties (TestParameter)
        Type = {'pageview', 'screenview', 'event', 'transaction', 'item', ...
            'social', 'timing', 'exception'} % hit types supported by google
    end % test parameters
    
    methods (Test)
        
        function hasAllTypes(testCase, Type)
            %HASALLTYPES Tests that we can enumerate all supported hit
            %types
            
            ht = testCase.verifyWarningFree(@() mga.hit.HitType.(Type));
            testCase.verifyEqual(ht.char, Type);
            
        end % hasAllTypes
        
    end % test methods
    
end % classdef