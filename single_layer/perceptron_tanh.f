      program perceptron
            real:: OI(4,3), TJ(4,1), W(3,1), OJ(4,1), DELTA(4,1)
            real:: ALPHA, start, finish, ERROR
            !args:
            !OI: training set
            !TJ: target val
            !W: weights
            !OJ: output

            open(unit=1,file='tanh_data1.out1',status='unknown')
            write(1,*) 'EPOCH       ERROR'
            
            !FORTRAN USED COLUMN-MAJOR ORDER
            !initializing data sets
            OI = reshape((/0,1,1,0,0,0,0,1,1,0,1,1/), (/4, 3/))
            !Matrix reads:    0 0 1
            !                 1 1 0
            !                 1 0 1
            !                 0 1 1

            TJ = reshape((/0,1,0,1/),(/4,1/))

            !initialize random weights
            do i=1,3
                  W(i,1:1) = 2.*rand()-1
            end do
            W = reshape(W,(/3,1/))

            ALPHA = 0.1

            call cpu_time(start)

            !training
            do i=1,10000
                  OJ = tanh(matmul(OI,W)) !transfer function tanh
                  DELTA = (OJ-TJ)*(1.-OJ**2) !tanh derivative 1-f(x)^2
                  W = W-ALPHA*matmul(transpose(OI),DELTA)

                  ERROR = sum(0.5*(TJ-OJ)**2)
                  write(1,*)i,',', ERROR
            end do

            call cpu_time(finish)

            print*, 'Training completed in ', finish-start
            print*, 'Initial learning rate:', ALPHA
            print*, 'Weights:', W
30          print*, 'Enter trial pattern:'
            read(*,*) x,y,z
            Z = x*W(1,1)+y*W(2,1)+z*W(3,1)
            print*,tanh(Z)
            goto 30
            

      end program perceptron