function path = mgaTestRoot
%MGATESTROOT Returns root path for mga toolbox test folder

% store path persistently for repeat calls
persistent r
if isempty(r)
    r = fileparts(mfilename('fullpath'));
end % if
path = r;

end % mgaTestRoot