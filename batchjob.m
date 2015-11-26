function batchjob(listname)

loadsubj

loadpaths

subjlist = eval(listname);

curpath = path;
matlabpath = strrep(curpath,':',''';''');
matlabpath = eval(['{''' matlabpath '''}']);
workerpath = cat(1,{pwd},matlabpath(1:end-1));

tasklist = {
%     'dataimport' 'subjlist(subjidx,1)'
    'epochdata' 'subjlist(subjidx,1)'
%     'ftcoherence' 'subjlist(subjidx,1)'
    };

j = 1;
for subjidx = 1:size(subjlist,1)
    for t = 1:size(tasklist,1)
        jobs(j).task = str2func(tasklist{t,1});
        jobs(j).input_args = eval(tasklist{t,2});
        jobs(j).n_return_values = 0;
        jobs(j).depends_on = 0;
        j = j+1;
    end
end

for j = 1:length(jobs)
    disp(jobs(j));
    jobs(j).task(jobs(j).input_args{:});
end

% P=cbupool(24);
% P.ResourceTemplate='-l nodes=^N^,mem=12GB,walltime=4:00:00';
% matlabpool(P);
% 
% parfor j = 1:length(jobs)
%     jobs(j).task(jobs(j).input_args{:});
% end

% scheduler = cbu_scheduler('custom',{jobqueue,numworkers,memory,walltime,jobspath});
% cbu_qsub(jobs,scheduler,workerpath);