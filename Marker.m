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
        trials;
    end
    methods (Static)
        function downsampledData=downsampleTo50Ms(data)
            %this function assumes that the data to be dowampled was
            %sampled at a rate of 8.333 ms
            %6*8.33ms=50 ms
            downsampledData.x=downsample(data.x,6);
            downsampledData.y=downsample(data.y,6);
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
            self.trials=trials;
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
                self.timeMovementOnset(trial)=self.MarkerData(trial).TrialData.timeMoveOnset;
                self.timeMovementEnd(trial)=self.MarkerData(trial).TrialData.timeMoveEnd;
                self.positions.x{trial}=self.MarkerData(trial).TrialData.Marker.rawPositions(:,2);
                self.positions.y{trial}=self.MarkerData(trial).TrialData.Marker.rawPositions(:,3);
                self.times{trial}=self.MarkerData(trial).TrialData.Marker.rawPositions(:,6);
                %velocity=(x_t-x_(t-1))/time
                self.velocity.x{trial}=(self.positions.x{trial}(2:end)-self.positions.x{trial}(1:end-1))/samplingRate;
                self.velocity.y{trial}=(self.positions.y{trial}(2:end)-self.positions.y{trial}(1:end-1))/samplingRate;
                
            end
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    %%%%%%%%%%%%% Data Structures %%%%%%%%%%%%%%%%%%
            % *positions* is a struct (x and y) with the number of cells
            % corresponding to the number of trials for x and y
            % respectively
            
            % *velocity* is a struct (x and y) with the number of cells
            % corresponding to the number of trials for x and y
            % respectively
            
            % *timeMovementOnset* and *timeMovementEnd* is a simple array
            % with the number of data points corresponding to the number of
            % trials
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        end
        function positions= getPostions(self)
            positions=self.positions;
        end
        function positions=getPositionsBetween(self,trial,beginTime,endTime)
            %first make a variable that is easier to work with
            allPositionsX=self.positions.x{trial};
            allPositionsY=self.positions.y{trial};
            %then take indexes from the time cell array
            allTimes=self.times{trial};
            indexes= allTimes>=beginTime & allTimes<=endTime;
            positions.x=allPositionsX(indexes);
            positions.y=allPositionsY(indexes);
        end
        function velocities=getVelocities(self)
            velocities=self.velocity;
        end
        function velocities=getVelocitiesBetween(self,trial,beginTime,endTime)
            %first make a variable that is easier to work with
            allVelocitiesX=self.velocity.x{trial};
            allVelocitiesY=self.velocity.y{trial};
            %then take indexes from the time cell array
            allTimes=self.times{trial};
            allTimes=allTimes(2:end);
            indexes= (allTimes>=beginTime & allTimes<=endTime);
            velocities.x=allVelocitiesX(indexes);
            velocities.y=allVelocitiesY(indexes);
        end
        
        function times=getTimes(self)
            times=self.times;
        end
        %higher level functions
        function [position,velocity, time]=getPositionVelocitesAndTime(self, trial)
            %first get data before and after movement onset
            movementOnset=self.timeMovementOnset(trial);%round here to the nearest 50 ms
            movementOnset=round(movementOnset/50)*50;
            movementEnd=self.timeMovementEnd(trial); %round to nearest 50 ms 
            movementEnd=round(movementEnd/50)*50;
            rawVelocities=self.getVelocitiesBetween(trial,(movementOnset-100),movementEnd);
            rawPositions=self.getPositionsBetween(trial,(movementOnset-100),movementEnd);
            position=Marker.downsampleTo50Ms(rawPositions);
            velocity=Marker.downsampleTo50Ms(rawVelocities);
            time=[(movementOnset-100),movementEnd];
        end

        
        
    end
    
end

