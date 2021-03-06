# Systems Neuroscience  

## Neural Constraints on Learning

### Introduction

Learning is the process of creating new activity patterns with groups of
neurons. Are some of these activity patterns easier to learn? Are there
limits to what a certain population of neurons are capable of
exhibiting? If so, what is the nature of these constraints? The
experiment involved a Rhesus macaques (Macaca mullatta) controlling a
computer cursor by changing neural activity in the primary motor cortex.
A brain computer interface (BCI) was used to record neural activity and
"specify and alter how neural activity mapped to cursor velocity." The
neural activity can be translated to a high dimensional space, the
’Neural space.’ In this space, each dimension represents the activity
of a single neuron. ’Activity patterns can create a low dimensional
subspace, termed the intrinsic manifold.’ This intrinsic manifold shows
the constraints imposed by the current neurocircuitry.

The paper shows that if activity patterns lie within this intrinsic
manifold, then they are easily learned and the monkey will be able to
’proficiently move the cursor’ around the screen. The activity
patterns that outside this manifold, can be shown to not be learnable
(i. e. after hours of practice, this activity cannot be learned). This
gives an explanation to why certain activity patterns in the brain are
easy to learn if it is a task that is similar to what has already been
done, and why other tasks are harder to learn if the brain does not have
experience in this domain.

The brain computer interface was used because all the activation of
neurons could be directly monitored and only these neurons lead to the
activity shown in the experiment.

**What is the Within Manifold Perturbation (WMP)? / Outside manifold
perturbation (OMP)?**

A within manifold perturbation is when the intuitive mapping is
perturbed to lie within the intrinsic manifold and an outside manifold
perturbation is when the intuitive mapping lie outside the manifold. The
WMP maintains the relationship of co-modulation patterns and neural
activity but changes the way that neuronal activity is mapped to the
control space and by extension, cursor kinematics. The OMP does not
maintain the relationship between the intrinsic co-modulation patterns
of neurons but also changes cursor kinematics. The performance will be
impaired by each perturbation but the question is whether or not the new
activity patterns are learnable. Two Rhesus macaques were trained in the
experiment to move the cursor by changing the neuronal activity of 81-91
neurons. The neural population activity is represented in the high
dimensional neural space. In each time step, neural activity is
transferred to the control (or action) space. This is a projected 
from the intrinsic manifold to cursor kinematics using a
Kalman filter.

At the start of the day, the ’intuitive mapping’ was established by
using a BCI mapping that the monkey used to control the cursor easily.
The neurons were also analyzed to see if they are ’co-modulated’ (i.e.
how they fire with the others).

Because of the different nature of the connections of neurons and the
co-modulation, the neuronal activity does not uniformly distribute the
neural space. Due to this fact, an intrinsic manifold can be described
that captures the neural activity in a lower dimensional space. The
intuitive mapping lies within this manifold.

What happens when the control space is within or outside this intrinsic
manifold?

The learning within the manifold is shown to be learnable within a short
amount of time while outside manifold perturbations are shown to not be
learnable.

After the perturbation, the learning is immediately impaired, but in the
within manifold perturbation, the monkey recovers, which is not shown in
the outside manifold perturbation.

The BCI mapping first mapped the neural population activity to the
intrinsic manifold using factor analysis, then the cursor kinematics
were derived from the intrinsic manifold using a Kalman filter.

**Some Alternative explanations**  
The manifold perturbations were checked to see how far off from the
intuitive mapping they lied (cosine distance).

The WMP and OMP were shown to be within the same distance from the
intuitive mapping.

Next, they checked to see if the neurons were seen to be in the same
direction, (i.e. the new mapping was in the preferred direction for each
of the neurons. How is the new control space perturbation defined?

How is the performance/progress defined?

## Methods

The neurons were recorded from the proximal arm region within the
primary motor cortex using 96 channel microelectrode while the monkeys
were in a chair with their head fixed.

The spike threshold was set to 3 times the root mean square voltage of
the baseline neural activity of a monkey in a dark room.

### Blocks

The calibration block completed each day, the intuitive mapping was
established. This mapping was used for 400 trials to establish some
baselines. The mapping was then switched to the perturbed mapping and
the task was completed again. A pertubation session was the combination
of the perturbation and washout blocks.

### Experimental sessions

78 sessions were completed which were composed of 30 within manifold
perturbations and 48 outside manifold perturbations. The session was
thrown out if fewer than 100 trials with the perturbed mapping were
attempted.

The cursor appeared on the screen for 300 ms. A juice reward was given
for each successfully completed task.

# Methods

## Peristimulus Time Histogram (PSTH)

A PSTH is simply a histogram of neurons firing during a specific
interval. This is useful to see how a set of neurons react to a
stimulus.

### Method

**Data:** Time sequential data ordered by time step

**For:** Beginning until End of analysis  
bin the data into equal time interval size bins

**End For**

## Tuning Curves

A tuning curves shows the firing rate as a response to a given stimulus
and is designed to show how a set of neurons can respond to directional
action. This can give insight into the preferred direction of the
neurons firing.

### Cosine Tuning Curves

Cosine tuning curves are a regression technique where you fit the two
parameters, the baseline- \(b _ i\) and the modulation depth \(k _ i\).
\[f _ i = b_ i + k _ i cos ( \theta _ {p, i} - \theta _ m )
    \label{eq:firingrates}\] \[p _ i = \left[ \begin{array}{c}
                    cos( \theta _ {p, i}) \\ 
                    sin( \theta _{p, i} ) 
                \end{array}
        \right]
        \label{eq:coodinates}\]

As shown in Equation [\[eq:firingrates\]](#eq:firingrates), \(f _ i\) is
the firing rates for a given time step. In order to solve this equation,
just switch the coordinate system to that shown in Equation
[\[eq:coodinates\]](#eq:coodinates).

The MATLAB program, `pmdDataSetup` should output the movement angle,
\(\theta _ m\) and the firing rates, \(f _ i\).

## Dimensionality Reduction of Neural Data

First use the aforementioned MATLAB program `pmdDataSetup` to get the
angle and firing rates for each of the neurons, then find the mean and
the covariance of the samples (See
[\[sec:factoranalysis\]](#sec:factoranalysis) for more information about
factor analysis).

The motivation for this work is to help aid in spike sorting, where the
data is intrinsically high dimensional and you would wish to gain some
more insight into the properties of this data.

A simple mathematical representation of neural data would be to define
it as follows: \[x _ n = \alpha _ n 
     \left[ \begin{array}{c}
                v _ 1\\
                v _ 2 \\
                \vdots
     \end{array}
          \right]
     + \beta_n  \left[ \begin{array}{c}
                v _ 1\\
                v _ 2 \\
                \vdots
     \end{array}
     \right]\]

Where \(V\) is the canonical waveform (wave thing), \(\alpha _ n\) is
the amplitude and \(\beta _ n\) is a baseline offset.

If this representation of the neurons are correct, then the degrees of
freedom of the neurons is two. In this case, only \(\alpha _ n\) and
\(\beta _n\) would change.

This would imply that the **intrinsic dimensionality** of the subspace
of the neural firing data would be two. Imagine a plot with the two axes
are defined by \(\alpha _ n\) and \(\beta _ n\), then two separate
neurons would be distinct and each point in the space would be a firing of the neuron.

In reality, these vectors are known and the true dimensionality and
number of vectors to define the firing of neural data must be determined
in ways described shortly.

You can visualize high dimensional neural data with spike count vectors
which simply show the amount a neuron fires in a given amount of time.

# Decoders

There is the issue of finding the optimal decoder for the problem of
translating population neural activity patterns to the movement of motor
objects such as a cursor on the screen or a robotic arm. PVA is the
simplest algorithm since it follows a general approach of weighting
certain neural activity based on its firing rates but it ignores factors
such as the neurons intrinsic modulation depth ( the the scale of the
baseline neural activity fluctuations ) and the baseline neural
activity.

## How the data is arranged

The point of a decoder is to generate a prediction of the position of
the hand movement or the velocity of the hand based on the neural
activity in order to create a mapping for BCI control. So, in simple
terms, the velocity is a function of the neural firing rate:
\[[V_x, V_y]= f(FiringRate)\]

## Linear Regression Decoding

In Linear Regression Decoding, you can use simple linear regression to
estimate the angle of the reach target (0 : 45 : 360) or the angular
velocity of the hand marker (\(\theta \in [0,360]\)).

To accomplish this we have to split up the data into training and
testing classes which will be used to assess generalization of the
model.

A simple decoder can regress the high dimensional neural population
activity to the target reach angle.

Another regression can directly estimate the x and y velocities of the
marker in order to decode the neural activity into cursor velocities.

## Population Vector Algorithm

The population vector algorithm takes the preferred direction of the
neurons (given by the cosine tuning curve) and calculates the movement
directions (velocities?). The equation should make intuitive sense
because it is just a weighted sum of the firing rates (how much that
neuron is active) and the preferred direction of that neuron. This is a
normalized value because \(textbf{p_i}\) is the defined as:

\[p_i &= \left[ \begin{array}{c}
                cos(\theta _ p)\\
                sin(\theta _ p) \\
     \end{array}
          \right]\]

And the overall algorithm can be solved analytically as:

\[\hat{m}  &= \left[ \begin{array}{c}
        \hat{m  _x} \\
         \hat{m  _y} \\
    \end{array}\right] &= \frac{\sum ^N _{i=1} f _ i p_i}{\sum ^N _{i=1} f _i }\]

## Optimal Linear Estimator (OLE)

OLE addresses the limitations of other decoders such as PVA while
retaining the same information about the neural population activity,
such as modulation depth, baseline and preferred direction. The rates used in this method are calculated differently than
PVA such that: \[r_i (t) &= \frac{f _i - b_i^D}{k_i}
    \label{eq:OLErate}\]

These values are smoothed so the last 5 time bins are used and averaged.
Using this, we can decode the cursor
velocity:

\[\overrightarrow{v}(t) &= k_s \frac{n_D}{N} \sum _{i=1} ^N r_i (t) \overrightarrow{p _i} ^D
    \label{eq:OLEdecoder}\]

In this case \(n_d\) is the number of dimensions for the decoder, and N
is the number of neurons. \(k_s\) is used as a speed factor to and
typically ranges from 65 to 80.

The trajectories of the cursor (its position) is updated using Euler’s
method.

**Implementation**

Given by the Cosine Tuning curve we can get the modulation depth, and
the preferred direction. From this we calculate Equation
[\[eq:OLErate\]](#eq:OLErate) and then Equation
[\[eq:OLEdecoder\]](#eq:OLEdecoder).

## Kalman Filter (KF)

A Kalman filter is a recurrent model which that says that the
probability of seeing an internal state \(Z_i\) is related to the
previous network dynamics \(Z_{i-1}\), with some weight matrix \(A\) and
covariance \(Q\) (guassian noise) (see equation [\[eq:z\]](#eq:z)). This
model varies from the other relationships in that this is a
**dynamical** model (i.e. it varies with time).

In general, you can write Z in terms of the Z in the previous time step
as: \[Z_i= N(A Z_{i-1}, Q)
    \label{eq:z}\]

With the inital Z as: \[Z_1 = N(\Pi, V)
    \label{eq:pi}\]

In this way, we can write x (the observation) also as a function of Z.

\[x=N(CZ,R)\]

This model employs the Markov Assumption which basically says that the
current state is only a function of the previous time step (no other
information needs to be used). Or in equation form, Z is a directed set
of causally linked events with no events further than one time step
influencing the current state.
\[p(Z_1....Z_T)=p(Z_1) \prod_{t=2} ^T {p(Z_t|Z_{t-1}})\] Then, we take
the total log probability of all the observations, x, and z’s and take
the derivative, and set to 0 with respect to certain parameters, we get
(in matrix notation):
\[A &= (\sum _{t=1} ^T Z_t Z_{t-1}^T)(\sum _{t=1} ^T Z_{t-1} Z_{t-1}^T)^{-1}
    \label{eq:a}\] In this situation, the values of Z are known because
this is a supervised learning situation, so A can be solved
analytically.
\[Q &= \frac{1}{T-1} \sum _{t=1}^T (z_t-Az_{t-1})(z_t-Az_{t-1})^T\]
Using the A derived from the last equation, you can also solve for Q in
an analytic fashion. \[C= (X Z^T)(X Z^T)^{-1}\] Like in Equation
[\[eq:a\]](#eq:a), this can also be solved directly.
\[R=\frac{1}{T} (X - CZ)(X-CZ)^{T}\] This equation can also be solved
for given the model parameters. And the recently derived matrix C.

In this way you have a way to find the probability of \(z_t | \{ x\}^t\)
which represents the probability of the latent z given all of the
observations x. This can be written recursively where the
\(p(z_t|\{x\}^t\) can be written in terms of \(p(z_t|\{x\}^{t-1}\).
Using all this information, we can derive that \[z_t= Az_{t-1} +v_t\]
\[v_t= N(0, Q)
    \label{eq:v}\]

Given this information, we can get the mean and covariance of z given
\(\{ x \}^{t-1}\).

The overall algorithm is to take the the sum over all trials in
training. In this case, that would be tantamount to adding up all the
different matrices, A, Q, C, and R over all trials.

Overall, because all the other distributions Z, X are Gaussian the joint
distribution of all of them will also be a Gaussian. This means that in
to sample over all the trials, we just need to look at the mean
(\(\mu\)) and covariance (\(\Sigma\)). We can derive (with Bayes Theorem
and other statistical logic) that the overall definitions for these
variables will be in this recursive form:
\[\mu_t = \mu_{t-1}+K_t(x_t- C\mu_{t-1})
   \label{eq:estimate}\] \[\Sigma_t=K_tC\Sigma_{t-1}\] where,
\[k_t=\Sigma_{t-1}C^T(C \Sigma_{t-1} C^T+R)^{-1}\] It is worth noting
that the values of \(\Pi\) and \(V\), in the case of multiple trials are
just the sample mean and covariance of those values.

In all this, the \(\mu\) value represents the estimate of the next state
(in our case, the next position, and velocity) and \(\Sigma\) represents
the uncertainty about the next state. Equation
[\[eq:estimate\]](#eq:estimate) can be read as the best estimate of the
current value, plus some Kalman gain (\(K_t\)) times the uncertainty of
the current state.


