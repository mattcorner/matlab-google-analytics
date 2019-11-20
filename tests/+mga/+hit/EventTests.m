classdef EventTests < matlab.unittest.TestCase
    %EVENTTESTS Tests for mga.hit.Event
    
    methods (Test, TestTags = "Unit")
        
        function canConstructWithRequiredInputs(testCase)
            %CANCONSTRUCTWITHREQUIREDINPUTS Tests that we can construct
            %with just the required inputs
            
            % construct warning free
            cat = "Unit tests";
            act = "Required inputs";
            evt = testCase.verifyWarningFree(@() mga.hit.Event(cat, act));
            
            % verify properties
            testCase.verifyEqual(evt.Category, cat);
            testCase.verifyEqual(evt.Action, act);
            
        end % canConstructWithRequiredInputs
        
        function canConstructWithOptionalInputs(testCase)
            %CANCONSTRUCTWITHOPTIONALINPUTS Tests that we can construct
            %with all required and optional inputs
            
            % construct warning free
            cat = "Unit tests";
            act = "Optional inputs";
            lbl = "A label";
            val = 123;
            ni = true;
            pvpairs = {'Label', lbl, ...
                'Value', val, ...
                'NonInteraction', ni};
            evt = testCase.verifyWarningFree(@() mga.hit.Event(cat, act, pvpairs{:}));
            
            % verify properties
            testCase.verifyEqual(evt.Category, cat);
            testCase.verifyEqual(evt.Action, act);
            testCase.verifyEqual(evt.Label, lbl);
            testCase.verifyEqual(evt.Value, val);
            testCase.verifyEqual(evt.NonInteraction, ni);
            
        end % canConstructWithOptionalInputs
        
        %getErrorOnOversizeCategory
        %getErrorOnOversizeAction
        %getErroronOversizeLabel
        %queryParametersForRequiredInputs
        %queryParametersForOptionalInputs
        
    end % unit test methods
    
end % classdef