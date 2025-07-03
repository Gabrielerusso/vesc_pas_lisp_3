; 3 wire PAS script made by Gabriele Russo
; brieruengineering@gmail.com
; connect +vcc to 5V, gnd to gnd, signal to PPM (servo) pin
; throttle -> adc0
; brake -> adc1 [OPTIONAL]

(define pas_prev 0)
(define pas_t 0)
(define pas_c 0)
(define pas_reset_t 0)
(define speed 0)
(define adc0_dec 0)
(define adc1_dec 1)
(define app_stat 1)
(define a_set_curr 0)
(define speed_l 0)

(gpio-configure 'pin-ppm 'pin-mode-in)

(sleep 5)

(defun read_ppm(){
    (if (> (gpio-read 'pin-ppm) 0)
        (if (< pas_prev  1){
            (setvar 'pas_prev 1)
            (setvar 'pas_t (systime))
            (if (< pas_c 100)
            (setvar 'pas_c (+ pas_c 1)))})
        (setvar 'pas_prev 0))

    (if (> (- (systime) pas_t) 10000){
        (setvar 'pas_c 0)
        (setvar 'pas_reset_t (systime))
        })
})

;;; enable/disable app-out
(defun app_output(o_s){
    (if (and (< app_stat 1) (> o_s 0)){
        (setvar 'app_stat 1)
        (app-disable-output 0)
        (sleep 0.1)})
    (if (and (> app_stat 0) (< o_s 1)){
        (setvar 'app_stat 0)
        (app-disable-output -1)
        (sleep 0.1)})})

(loopwhile-thd 64 t {
    (read_ppm())
    (sleep 0.01)
})

(app_output 0)

(loopwhile t {
    (setvar 'speed (* (get-speed) 3.6))
    (setvar 'adc1_dec 0.0) ;brake replace 0.0 with (get-adc-decoded 1) if brake is used
    (setvar 'adc0_dec (get-adc-decoded 0)) ;throttle

    (if (> pas_c 2)
        (if (and (< adc0_dec 0.05) (< adc1_dec 0.05)){
            (if (< speed_l 7)
                {(conf-set 'max-speed (/ 25 3.6))
                (setvar 'speed_l 25)})
            (if (< a_set_curr 1.0)
                (setvar 'a_set_curr (+ a_set_curr 0.025))) ;throttle filter constant
            (app_output 0)
            (set-current-rel a_set_curr)}
            (app_output 1))
        {
            (if (> speed_l 6)
                {(conf-set 'max-speed (/ 6 3.6))
                (setvar 'speed_l 6)})
            (if (>= a_set_curr 0.1)
                (setvar 'a_set_curr (- a_set_curr 0.05)))
            (app_output 1)
        }
    (sleep 0.1)
})
