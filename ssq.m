rand('state',0); % produce same sequence of random numbers every time you run the code..
disp('This is a single server queue');
customers = [10 50 100 500 1000];
ar = [.1 .3 .5 .7 .9];
sr = [.2 .2 .4 .6 .8];
ED = [];
EQ = [];
EU = [];
disp('Press 1 to use LIFO techique.');
disp('Press 2 to use SJF techique.');
ch = input('Enter your choice: ');
if ch == 1
    sim = 1;
    while (sim <= length(customers))
        serverBusy = 0;
        delay = 0; 
        customersServed = 0; 
        Queue = [];
        QueueST = [];
        tempQueue = [];
        top = 0;
        %ArrivalTime = [0 7 14 15 23 26];
        %ServiceTime = [9 7 6 7 8 4];
        pa = ar(sim);
        ps = sr(sim);
        nz = 1;
        ArrivalTime(1) = geometric(pa);
        for i=2:customers(sim)
            ArrivalTime(i) = geometric(pa) + ArrivalTime(i-1);
        end
        disp('Arrival Time: ');
        %disp(ArrivalTime);
        %disp('Service Time: ');
        %disp(ServiceTime);
        next = 1;
        nextArrival = ArrivalTime(next);
        nextDeparture = realmax;
        currentTime = 0;
        timeQuantum = 0;
        ex_number = 0;
        ut = 0;
        while(customersServed < customers(sim))
            if currentTime == nextDeparture
                if top == 0
                    serverBusy = 0;
                    nextDeparture = realmax;
                    disp('departure completed');
                elseif top > 0
                    disp('Queue: ');
                    for i=1:top
                        fprintf('%d ', Queue(i));
                    end
                    disp('\n');
                    x = sprintf('%d remove from queue',Queue(top));
                    disp(x);
                    temp = geometric(ps);
                    x = sprintf('service time for %d is %d',Queue(top),temp);
                    disp(x);
                    delay = delay + (currentTime - Queue(top));
                    x = sprintf('delay: %d',delay);
                    disp(x);
                    top = top - 1;
                    customersServed = customersServed + 1;
                    serverBusy = 1;
                    nextDeparture = currentTime + temp;
                    nz = nz + 1;
                    x = sprintf('nextDeparture: %d',nextDeparture);
                    disp(x);
                    x = sprintf('customersServed: %d',customersServed);
                    disp(x);
                end

            %disp('*****************************');
            elseif currentTime == nextArrival
                if serverBusy == 0
                    customersServed = customersServed + 1;
                    serverBusy = 1;
                    temp = geometric(ps);
                    nextDeparture = currentTime + temp;
                    nz = nz + 1;
                    x = sprintf('service time for %d is %d',nextArrival, temp);
                    disp(x);
                    x = sprintf('nextDeparture: %d',nextDeparture);
                    disp(x);
                    x = sprintf('customersServed: %d',customersServed);
                    disp(x);

                elseif serverBusy == 1
                    top = top + 1;
                    Queue(top) = nextArrival;
                    x = sprintf('%d inserted in quque',nextArrival);
                    disp(x);
                end
                if(next < customers(sim))
                    next = next + 1;
                    nextArrival = ArrivalTime(next);
                else
                    nextArrival = realmax;
                end
                x = sprintf('nextArrival: %d',nextArrival);
                disp(x);
            end
            x = sprintf('currentTime: %d',currentTime);
            disp(x);
            oldtime = currentTime;
            if(nextDeparture <= nextArrival)
                currentTime = nextDeparture;
            else 
                currentTime = nextArrival;
            end
            h = (currentTime - oldtime) * top;
            x = sprintf('%d,%d,%d,%d',currentTime,oldtime,top,h);
            disp(x);
            x = sprintf('server busy: %d',serverBusy);
            disp(x);
            ex_number = ex_number + (currentTime - oldtime) * top;
            ut = ut + (currentTime - oldtime) * serverBusy;
            x = sprintf('next currentTime: %d',currentTime);
            disp(x);
            disp('*****************************');
        end

        disp('*****************************');
        x = sprintf('Average delay: %0.2f',delay/customers(sim));
        disp(x);
        ED(sim) = delay/customers(sim);
        x = sprintf('Expected Number of Customers in Queue: %0.2f',ex_number/nextDeparture);
        disp(x);
        EQ(sim) = ex_number/nextDeparture;
        x = sprintf('Utilization of the Server: %0.2f',ut/nextDeparture);
        disp(x);
        EU(sim) = ut/nextDeparture;
        sim = sim + 1;
    end
    disp('Average Delay:');
    disp(ED);

    disp('Expected Number of Customers in Queue:');
    disp(EQ);

    disp('Utilization of the Server:');
    disp(EU);

    plot(ar,ED,ar,EQ,ar,EU,sr,ED,sr,EQ,sr,EU);
    xlim([.1 0.9]);
    ylim([-10 80]);
    legend({'AR vs ED','AR vs EQ','AR vs EU', 'SR vs ED', 'SR vs EQ', 'SR vs EU'});
    hold on;
elseif ch == 2
    sim = 1;
    while (sim <= length(customers))
        serverBusy = 0;
        delay = 0; 
        customersServed = 0; 
        Queue = [];
        QueueST = [];
        top = 0;
        %ArrivalTime = [0 7 14 15 23 26];
        %ServiceTime = [9 7 6 7 8 4];
        pa = ar(sim);
        ps = sr(sim);
        nz = 1;
        ArrivalTime(1) = geometric(pa);
        for i=2:customers(sim)
            ArrivalTime(i) = geometric(pa) + ArrivalTime(i-1);
        end
        %disp('Arrival Time: ');
        %disp(ArrivalTime);
        %disp('Service Time: ');
        %disp(ServiceTime);
        next = 1;
        nextArrival = ArrivalTime(next);
        nextDeparture = realmax;
        currentTime = 0;
        timeQuantum = 0;
        ex_number = 0;
        ut = 0;
        while(customersServed < customers(sim))
            if currentTime == nextDeparture
                if top == 0
                    serverBusy = 0;
                    nextDeparture = realmax;
                    disp('departure completed');
                elseif top > 0
                    disp('Queue: ');
                    for i=1:top
                        fprintf('%d ', Queue(i));
                    end
                    disp('Queue Service Time: ');
                    for i=1:top
                        fprintf('%d ', QueueST(i));
                    end
                    disp('\\n');
                    x = sprintf('%d remove from queue',Queue(top));
                    disp(x);
                    temp = QueueST(top);
                    x = sprintf('service time for %d is %d',Queue(top),temp);
                    disp(x);
                    delay = delay + (currentTime - Queue(top));
                    Queue(top) = [];
                    QueueST(top) = [];
                    x = sprintf('delay: %d',delay);
                    disp(x);
                    top = top - 1;
                    customersServed = customersServed + 1;
                    serverBusy = 1;
                    nextDeparture = currentTime + temp;
                    nz = nz + 1;
                    x = sprintf('nextDeparture: %d',nextDeparture);
                    disp(x);
                    x = sprintf('customersServed: %d',customersServed);
                    disp(x);
                end

            %disp('*****************************');
            elseif currentTime == nextArrival
                if serverBusy == 0
                    customersServed = customersServed + 1;
                    serverBusy = 1;
                    temp = geometric(ps);
                    nextDeparture = currentTime + temp;
                    nz = nz + 1;
                    x = sprintf('service time for %d is %d',nextArrival, temp);
                    disp(x);
                    x = sprintf('nextDeparture: %d',nextDeparture);
                    disp(x);
                    x = sprintf('customersServed: %d',customersServed);
                    disp(x);

                elseif serverBusy == 1
                    top = top + 1;
                    Queue(top) = nextArrival;
                    QueueST(top) = geometric(ps);
                    [~,QueueSTsort] = sort(QueueST,'descend');
                    Queue = Queue(QueueSTsort);
                    %Queue = tempQueue;
                    QueueST = sort(QueueST,'descend');
                    %disp(Queue);
                    %disp(QueueST);
                    x = sprintf('%d inserted in quque',nextArrival);
                    disp(x);
                end
                if(next < customers(sim))
                    next = next + 1;
                    nextArrival = ArrivalTime(next);
                else
                    nextArrival = realmax;
                end
                x = sprintf('nextArrival: %d',nextArrival);
                disp(x);
            end
            x = sprintf('currentTime: %d',currentTime);
            disp(x);
            oldtime = currentTime;
            if(nextDeparture <= nextArrival)
                currentTime = nextDeparture;
            else 
                currentTime = nextArrival;
            end
            h = (currentTime - oldtime) * top;
            x = sprintf('%d,%d,%d,%d',currentTime,oldtime,top,h);
            disp(x);
            x = sprintf('server busy: %d',serverBusy);
            disp(x);
            ex_number = ex_number + (currentTime - oldtime) * top;
            ut = ut + (currentTime - oldtime) * serverBusy;
            x = sprintf('next currentTime: %d',currentTime);
            disp(x);
            disp('*****************************');
        end

        disp('*****************************');
        x = sprintf('Average delay: %0.2f',delay/customers(sim));
        disp(x);
        ED(sim) = delay/customers(sim);
        x = sprintf('Expected Number of Customers in Queue: %0.2f',ex_number/nextDeparture);
        disp(x);
        EQ(sim) = ex_number/nextDeparture;
        x = sprintf('Utilization of the Server: %0.2f',ut/nextDeparture);
        disp(x);
        EU(sim) = ut/nextDeparture;
        sim = sim + 1;
    end
    disp('Average Delay:');
    disp(ED);

    disp('Expected Number of Customers in Queue:');
    disp(EQ);

    disp('Utilization of the Server:');
    disp(EU);

    plot(ar,ED,ar,EQ,ar,EU,sr,ED,sr,EQ,sr,EU);
    xlim([.1 0.9]);
    ylim([-10 80]);
    legend({'AR vs ED','AR vs EQ','AR vs EU', 'SR vs ED', 'SR vs EQ', 'SR vs EU'});
    hold on;
else
    disp('error input');
end







