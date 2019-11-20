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
        
        function getErrorOnOversizeCategory(testCase)
            %GETERRORONOVERSIZECATEGORY Test that the google byte limit on
            %Event Category is honoured
            
            % verify error on construction
            cat = "Ssjda59fNw27CQFyoN8c IJ1ikJm9vsoxcGp1DYjN 4CmLxS62vHSyatFAcbVh" + ...
                "PAmODrv0prZNlXiJAO4C F9Lg8Sk3U7HDjjZf6EjX f8gwkl4u47hynFWvzBUf" + ...
                "YnScIZa8J1A17GbkHdwY dZ4WVEJGJjn3Wdg9EPGv bHYbnUMrWGzZUK2K8DXL";
            act = "Oversize category";
            testCase.verifyError(@() mga.hit.Event(cat, act), 'Hit:maxLengthExceeded');
            
        end % getErrorOnOversizeCategory
        
        function getErrorOnOversizeAction(testCase)
            %GETERRORONOVERSIZEACTION Test that the google byte limit on
            %Event Action is honoured
            
            % verify error on construction
            cat = "Oversized action";
            act = "Ssjda59fNw27CQFyoN8c IJ1ikJm9vsoxcGp1DYjN 4CmLxS62vHSyatFAcbVh" + ...
                "PAmODrv0prZNlXiJAO4C F9Lg8Sk3U7HDjjZf6EjX f8gwkl4u47hynFWvzBUf" + ...
                "YnScIZa8J1A17GbkHdwY dZ4WVEJGJjn3Wdg9EPGv bHYbnUMrWGzZUK2K8DXL" + ...
                "Ssjda59fNw27CQFyoN8c IJ1ikJm9vsoxcGp1DYjN 4CmLxS62vHSyatFAcbVh" + ...
                "PAmODrv0prZNlXiJAO4C F9Lg8Sk3U7HDjjZf6EjX f8gwkl4u47hynFWvzBUf" + ...
                "YnScIZa8J1A17GbkHdwY dZ4WVEJGJjn3Wdg9EPGv bHYbnUMrWGzZUK2K8DXL" + ...
                "Ssjda59fNw27CQFyoN8c IJ1ikJm9vsoxcGp1DYjN 4CmLxS62vHSyatFAcbVh" + ...
                "YnScIZa8J1A17GbkHdwY dZ4WVEJGJjn3Wdg9EPGv bHYbnUMrWGzZUK2K8DXL" + ...
                "YnScIZa8J1A17GbkHdwY dZ4WVEJGJjn3Wdg9EPGv bHYbnUMrWGzZUK2K8DXL";
            testCase.verifyError(@() mga.hit.Event(cat, act), 'Hit:maxLengthExceeded');
            
        end % getErrorOnOversizeAction
        
        function getErrorOnOversizeLabel(testCase)
            %GETERRORONOVERSIZELABEL Test that the google byte limit on
            %Event Label is honoured
            
            % verify error on construction
            cat = "Oversized label";
            act = "Action";
            lbl = "Ssjda59fNw27CQFyoN8c IJ1ikJm9vsoxcGp1DYjN 4CmLxS62vHSyatFAcbVh" + ...
                "PAmODrv0prZNlXiJAO4C F9Lg8Sk3U7HDjjZf6EjX f8gwkl4u47hynFWvzBUf" + ...
                "YnScIZa8J1A17GbkHdwY dZ4WVEJGJjn3Wdg9EPGv bHYbnUMrWGzZUK2K8DXL" + ...
                "Ssjda59fNw27CQFyoN8c IJ1ikJm9vsoxcGp1DYjN 4CmLxS62vHSyatFAcbVh" + ...
                "PAmODrv0prZNlXiJAO4C F9Lg8Sk3U7HDjjZf6EjX f8gwkl4u47hynFWvzBUf" + ...
                "YnScIZa8J1A17GbkHdwY dZ4WVEJGJjn3Wdg9EPGv bHYbnUMrWGzZUK2K8DXL" + ...
                "Ssjda59fNw27CQFyoN8c IJ1ikJm9vsoxcGp1DYjN 4CmLxS62vHSyatFAcbVh" + ...
                "YnScIZa8J1A17GbkHdwY dZ4WVEJGJjn3Wdg9EPGv bHYbnUMrWGzZUK2K8DXL" + ...
                "YnScIZa8J1A17GbkHdwY dZ4WVEJGJjn3Wdg9EPGv bHYbnUMrWGzZUK2K8DXL";
            testCase.verifyError(@() mga.hit.Event(cat, act, 'Label', lbl), 'Hit:maxLengthExceeded');
            
        end % getErrorOnOversizeLabel
        %queryParametersForRequiredInputs
        %queryParametersForOptionalInputs
        
    end % unit test methods
    
end % classdef