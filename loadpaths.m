function loadpaths

[~, hostname] = system('hostname');

if strncmpi(hostname,'hsbpc58',length('hsbpc58'))
    assignin('caller','nsfpath','/Users/chennu/Data/RestingState/');
    assignin('caller','filepath','/Users/chennu/Data/RestingState/save/');
    assignin('caller','chanlocpath','/Users/chennu/Work/EGI/');

elseif strncmpi(hostname,'hsbpc57',length('hsbpc57'))
    assignin('caller','filepath','D:\Data\RestingState\');
    assignin('caller','chanlocpath','D:\Work\EGI\');

else
    assignin('caller','filepath','');
    assignin('caller','chanlocpath','');
end