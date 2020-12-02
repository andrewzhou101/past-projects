/*
Author: Andrew Zhou
Purpose: Make a basic security system by implementing an embedded system.
Assignment: Project 2

References: 

Other: My person number is 50270365, so the 4 digit code will be 0365.
 */ 
 // Inputs: 4 Inputs for each column in keypad.
// Outputs: 1 output for LED. 2 outputs for LED display. 4 Inputs for each row in keypad. 7 outputs total.

#include "mbed.h"
#include "1802.h"                           // location of prototyping and definitions for 1802 LCD

EventQueue qu(32*EVENTS_EVENT_SIZE);        // Create event queue
Thread t;                                   // Define object type Thread
int row = 0;                                // Define value to check rows
void c4isr(void);                           // define column4 isr
void c3isr(void);                           // define column3 isr
void c2isr(void);                           // define column2 isr
void c1isr(void);                           // define column1 isr
void updateCode(void);                      // define code function
void offLED(void);                          // function to turn off LED

// setting up interrupt objects
InterruptIn column4 (PC_8, PullDown);
InterruptIn column3 (PC_9, PullDown);
InterruptIn column2 (PC_10, PullDown);
InterruptIn column1 (PC_11, PullDown);

Ticker t1;                                  // Ticker will decide when inputs happen.
Ticker t2;                                  // Ticker will turn off LED.
int digit = 0;                              // Which digit of the code is next
int recent = 0;                             // Holds the most recent button press
int check = 0;                              // If 0, no numbers have been pressed. If 1, numbers have been pressed.
int code = 0;                               // Holds the current code value
int state = 0;                              // Create variable to hold Locked/Unlocked 0 = Locked, 1 = Unlocked

CSE321_LCD lcd(16,2,LCD_5x8DOTS,PF_0,PF_1);
// PF0 = SDA, PF1 = SCL

// main() runs in its own thread in the OS



int main(){
    t.start(callback(&qu, &EventQueue::dispatch_forever));      // Make event queue dispatch forever
    lcd.begin();                            // initialize LCD
    t2.attach(qu.event(offLED), .5);        // Turns off LED every .5 seconds
    t1.attach(qu.event(updateCode), 1);     // attach Ticker to run updateCode

    RCC->AHB2ENR |= 0x6;                    // Enable Clock for GPIOC and GPIOB
    // Use Port B for inputs
    GPIOC->MODER &= ~(0x00FF0000);          // Set 0s for 8/9/10/11
    // Use Port C for outputs
    GPIOB->MODER &= ~(0x00AA0002);          // Set 0s for Registers 0/8/9/10/11
    GPIOB->MODER |= 0x00550001;             // Set 1s for Registers 0/8/9/10/11

    // Set up interrupt behavior
    column4.rise(qu.event(c4isr));
    column3.rise(qu.event(c3isr));
    column2.rise(qu.event(c2isr));
    column1.rise(qu.event(c1isr));
    column4.enable_irq();
    column3.enable_irq();
    column2.enable_irq();
    column1.enable_irq();

    while (true) {                          // Code that will run over and over (polling)
        if(row == 0){                       // If currently row 0
            row = 1;                        // Go to next row
            GPIOB->ODR &= ~(0x100);         // Set 0 for previous pin
            GPIOB->ODR |= 0x200;            // Set 1 for the pin that represents next row (PB9)
        }
        else if(row == 1){                  // If currently row 1
            row = 2;                        // Go to next row
            GPIOB->ODR &= ~(0x200);         // Set 0 for previous pin
            GPIOB->ODR |= 0x400;            // Set 1 for the pin that represents this row (PB10)
        }
        else if(row == 2){                  // If currently row 2
            row = 3;                        // Go to next row
            GPIOB->ODR &= ~(0x400);         // Set 0 for previous pin
            GPIOB->ODR |= 0x800;            // Set 1 for the pin that represents this row (PB11)
        }
        else if(row == 3){                  // If currently row 3
            row = 0;                        // This is last row, so go back to row 0
            GPIOB->ODR &= ~(0x800);         // Set 0 for previous pin
            GPIOB->ODR |= 0x100;            // Set 1 for the pin that represents this row (PB8)
        }
        thread_sleep_for(50);               // 50ms sleep
    }
    return 0;
}


// additional functions

void c4isr(void){                           // Column 4 is A/B/C/D
    // Display value to console. If it is a valid number, check = 1, recent = pushed button.
    if(row == 0){
        printf("A\n");
        recent = 10;
        check = 1;
    }
    else if(row == 1){
        printf("B\n");
    }
    else if(row == 2){
        printf("C\n");
    }
    else if(row == 3){
        printf("D\n");
    }
    wait_us(10000);                         // wait 10000 microseconds or 0.01 seconds
}
void c3isr(void){                           // Column 3 is 3/6/9/#
    // Display value to console. If it is a valid number, check = 1, recent = pushed button.
    if(row == 0){
        printf("3\n");
        recent = 3;
        check = 1;
    }
    else if(row == 1){
        printf("6\n");
        recent = 6;
        check = 1;
    }
    else if(row == 2){
        printf("9\n");
        recent = 9;
        check = 1;
    }
    else if(row == 3){
        printf("#\n");
    }
    wait_us(10000);                        // wait 10000 microseconds or 0.01 seconds
}
void c2isr(void){                           // Column 2 is 2/5/8/0
    // Display value to console. If it is a valid number, check = 1, recent = pushed button.
    if(row == 0){
        printf("2\n");
        recent = 2;
        check = 1;
    }
    else if(row == 1){
        printf("5\n");
        recent = 5;
        check = 1;
    }
    else if(row == 2){
        printf("8\n");
        recent = 8;
        check = 1;
    }
    else if(row == 3){
        printf("0\n");
        recent = 0;
        check = 1;
    }
    wait_us(10000);                        // wait 10000 microseconds or 0.01 seconds
}
void c1isr(void){                           // Column 1 is 1/4/7/star
    // Display value to console. If it is a valid number, check = 1, recent = pushed button.
    if(row == 0){
        printf("1\n");
        recent = 1;
        check = 1;
    }
    else if(row == 1){
        printf("4\n");
        recent = 4;
        check = 1;
    }
    else if(row == 2){
        printf("7\n");
        recent = 7;
        check = 1;
    }
    else if(row == 3){
        printf("*\n");
    }
    wait_us(10000);                         // wait 10000 microseconds or 0.01 seconds
}

void updateCode(void){
    lcd.clear();                            // Clear lcd because only this function writes to it
    if(check == 1){                         // Check if any button presses have happened in the last second.
        check = 0;                          // reset the variable that checks button presses.
        if(recent == 10){                   // if recent == 10, button pushed is A, so reset all values.
            digit = 0;
            code = 0;
            lcd.setCursor(0,1);
            lcd.print("Reset");             // print "Reset"
        }
        else if(digit == 0){                // First digit is added to code
            code = recent * 1000;
            digit++;
        }
        else if(digit == 1){                // Second digit is added to code
            code = code + (recent * 100);
            digit++;
        }
        else if(digit == 2){                // Third digit is added to code
            code = code + (recent * 10);
            digit++;
        }
        else if(digit == 3){                // Fourth digit is added to code
            code = code + (recent);
            if(code == 365){                // Code is checked, locks if wrong, unlocks if right.
                state = 1;
            }
            else{
                state = 0;
                lcd.setCursor(0,1);
                lcd.print("Wrong Code");
            }
            digit = 0;
            code = 0;
            
        }
        GPIOB->ODR |= 0x1;                  // Turn on LED
    }
    
    lcd.setCursor(0,0);
    if(state == 0){                     // if Locked, print Locked on LCD
        lcd.print("Locked");
    }
    else{                               // otherwise, print unlocked
        lcd.print("Unlocked");
    }
    
}

void offLED(void){
    GPIOB->ODR &= ~(0x1);               // Turn off LED at regular intervals
}