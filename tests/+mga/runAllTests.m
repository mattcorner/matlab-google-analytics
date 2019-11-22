clear classes %#ok<CLCLS>
suite = matlab.unittest.TestSuite.fromPackage('mga', ...
    'IncludingSubPackages', true);
runner = matlab.unittest.TestRunner.withTextOutput;
runner.addPlugin(matlab.unittest.plugins.CodeCoveragePlugin.forFolder(mgaRoot, ...
    'IncludingSubFolders', true));
runner.run(suite);