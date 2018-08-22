classdef Marker <handle
    %This class is designed to represent parameters of the Marker position
    %and velocity using the struct datatype given by the Center for the Neural Basis
    %of Cognition, Pittsburgh PA. The properties and methods of this object
    %should be clear from the name and if not, then an extended
    %description is given under the function header
    properties (SetAccess =private)
        positions;
        velocity;
        times;
        MarkerData;
        timeMovementOnset;
        timeMovementEnd;
    end
    methods (Static)
        function downsampledData=downsampleTo50Ms(data)
            %this function assumes that the data to be dowampled was
            %sampled at a rate of 8.333 ms
            %6*8.33ms=50 ms
            downsampledData=downsample(data,6);
        end
    end
    methods
        function self = Marker(MarkerDataFilename, dataIsInWorkspace)
            if (dataIsInWorkspace)
                self.MarkerData=evalin('base', 'Data');
                %load only successful trials
                ov = [self.MarkerData.Overview];
                success = [ov.trialStatus] == 1;
                self.MarkerData = self.MarkerData(success);
            else
                
                self.MarkerData=load(MarkerDataFilename);
                self.MarkerData=self.MarkerData.Data;
                %load only successful trials
                ov = [self.MarkerData.Overview];
                success = [ov.trialStatus] == 1;
                self.MarkerData = self.MarkerData(success);                
            end
            

            
            trials=size(self.MarkerData, 2);
            self.timeMovementOnset=zeros(1, trials);
            self.positions.x={trials};
            self.positions.y={trials};
            
            %because we are dealing with deltas, the first trial cannot be
            %used
            
            self.velocity.x={trials};
            self.velocity.y={trials};  
            self.times={trials};
            %this is the sampling rate in milliseconds
            samplingRate=25/3;
            for trial=1:trials
                disp(trial)
                self.timeMovementOnset(trial)=self.MarkerData(trial).TrialData.timeMoveOnset;
                self.timeMovementEnd(trial)=self.MarkerData(trial).TrialData.timeMoveEnd;
                self.positions.x{trial}=self.MarkerData(trial).TrialData.Marker.rawPositions(:,2);
                self.positions.y{trial}=self.MarkerData(trial).TrialData.Marker.rawPositions(:,3);
                self.times{trial}=self.MarkerData(trial).TrialData.Marker.rawPositions(:,3);
                %velocity=(x_t-x_(t-1))/time
                self.velocity.x{trial}=(self.positions.x{trial}(2:end)-self.positions.x{trial}(1:end-1))/samplingRate;
                self.velocity.y{trial}=(self.positions.y{trial}(2:end)-self.positions.y{trial}(1:end-1))/samplingRate;
                
            end
            
            

        end
        function positions= getPostions(self)
            positions=self.positions;
        end
        function positions=getPositionsBetween(self,trial,beginTime,endTime)
            %first make a variable that is easier to work with
            allPositions=self.positions.x{trial};
            %then take indexes from the time cell array
            allTimes=self.times{trial};
            indexes= allTimes>=beginTime && allTimes<=endTime;
            positions=allPositions(indexes);
            
        end
        function velocities=getVelocities(self)
            velocities=self.velocity;
        end
        function velocities=getVelocitiesBetween(self,trial,beginTime,endTime)
            %first make a variable that is easier to work with
            allVelocities=self.velocites.x{trial};
            %then take indexes from the time cell array
            allTimes=self.times{trial};
            indexes= allTimes>=beginTime && allTimes<=endTime;
            velocities=allVelocities(indexes);
        end
        
        function times=getTimes(self)
            times=self.times;
        end
        %higher level functions
        function [position,velocity, time]=getPositionVelocitesAndTime(self, trial)
            %first get data before and after movement onset
            movementOnset=self.timeMovementOnset(trial);
            movementEnd=self.timeMovementEnd(trial);
            rawVelocities=self.getVelocitiesBetween(trial,(movementOnset-100),movementEnd);
            rawPositions=self.getPositionsBetween(trial,(movementOnset-100),movementEnd);
            position=Marker.downsampleTo50Ms(rawPositions);
            velocity=Marker.downsampleTo50Ms(rawVelocities);
            time=[(movementOnset-100),movementEnd];
            
        end
        %first, calculate position velocity, and spike counts in 50 ms bins
        % 100 ms before movement onset til the end of the movement ( ms)
        
        
    end
    
end

