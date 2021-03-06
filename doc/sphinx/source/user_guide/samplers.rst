.. _samplers:

Samplers
------------------------------------------------------------------------------------------

This section discusses the package's Monte Carlo samplers assuming MCMC knowledge on the user's part.
The interested user is referred to relevant literature for more background information.
Each sampler is an immutable type. The types' fields correspond to the samplers' defining attributes.

The table below summarizes up to which order of log-target derivatives are required by each sampler. First, second and
third order derivatives correspond to the ``model()`` keyword arguments ``grad``, ``tensor`` and ``dtensor``.

+---------------+---------+---------+---------+
| Sampler       | grad    | tensor  | dtensor |
+===============+=========+=========+=========+
| ARS           |    ✗    |    ✗    |    ✗    |
+---------------+---------+---------+---------+
| SliceSampler  |    ✗    |    ✗    |    ✗    |
+---------------+---------+---------+---------+
| MH            |    ✗    |    ✗    |    ✗    |
+---------------+---------+---------+---------+
| RAM           |    ✗    |    ✗    |    ✗    |
+---------------+---------+---------+---------+
| HMC           |    ✓    |    ✗    |    ✗    |
+---------------+---------+---------+---------+
| HMCDA         |    ✓    |    ✗    |    ✗    |
+---------------+---------+---------+---------+
| NUTS          |    ✓    |    ✗    |    ✗    |
+---------------+---------+---------+---------+
| MALA          |    ✓    |    ✗    |    ✗    |
+---------------+---------+---------+---------+
| SMMALA        |    ✓    |    ✓    |    ✗    |
+---------------+---------+---------+---------+
| RMHMC         |    ✓    |    ✓    |    ✓    |
+---------------+---------+---------+---------+
| PMMALA        |    ✓    |    ✓    |    ✓    |
+---------------+---------+---------+---------+


.. _ars:

ARS
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The *acceptance-rejection method*, also known as *rejection sampling*, was introduced by :cite:`neu:var` . For a more
recent treatment see for example :cite:`rob:cas:mon,bol:und`. Suppose that it is diffcult to attain samples from a
target distribution
:math:`f(x)`.
Instead, assume that it is easier to sample from an alternative proposal density
:math:`g(x)` which satisfies
:math:`f(x)<cg(x)` for some constant
:math:`c>1`.
Due to this inequality,
:math:`cg(x)`
is also called the *envelope*. Rejection sampling allows to sample from
:math:`f(x)`
indirectly by sampling instead from the instrumental proposal
:math:`g(x)`.

The acceptance-rejection sampler is represented by the ``ARS`` type in Julia, whose fields are provided below:

+---------------+--------------+---------+---------+---------------+
| ARS field     | Field type   | Required/optional | Default value |
+===============+==============+=========+=========+===============+
| logproposal   | Function     | Required          | ✗             |
+---------------+--------------+---------+---------+---------------+
| proposalscale | Float64      | Optional          | 1.0           |
+---------------+--------------+---------+---------+---------------+
| jumpscale     | Float64      | Optional          | 1.0           |
+---------------+--------------+---------+---------+---------------+

``logproposal`` refers to the log-proposal
:math:`g(x)`.
``proposalscale`` is a scale factor used for ensuring that the scaled-up proposal covers the target.
``jumpscale`` is a scale factor for adapting the jump size.

Below is a demonstration of how the ``ARS`` constructor can be invoked:

.. code-block:: julia
  :linenos:

  ARS(x -> -dot(x, x)/2)

  ARS(x -> -dot(x, x)/2; proposalscale=1.5, jumpscale=0.9)


.. _slice_sampler:

SliceSampler
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The seeds for discovering *slice sampling* were planted mainly in the works of :cite:`edw:sok:gen,dam:wak:wal:gib`,
while :cite:`nea:sli` offers a more contemporary exposition. A slice sampling method facilitates sampling from a
possibly unnormalized density by sampling uniformly from the region under the density's graph. In fact, the method
entails alternating between two uniform sampling steps, one in the horizontal *slice* direction from a subset of the
density's domain and one in the vertical direction from the density's corresponding pre-image. Since the support for the
two involved uniforms is set adaptively for each iteration of the algorithm, slice sampling does not require much
tuning. For this reason, it is a more automated alternative to Gibbs or Metropolis sampling. On the other hand, slice
sampling works for univariate continuous variables. In the multivariate case, it updates one variable at a time, which
is not so helpful if the variables are correlated.

The fields of ``SliceSampler`` are the following:

+--------------------+-----------------+---------+---------+---------------+
| SliceSampler field | Field type      | Required/optional | Default value |
+====================+=================+=========+=========+===============+
| widths             | Vector{Float64} | Optional          | Float64[]     |
+--------------------+-----------------+---------+---------+---------------+
| stepout            | Bool            | Optional          | true          |
+--------------------+-----------------+---------+---------+---------------+

``widths`` provides step-sizes for initially expanding the slice, while ``stepout`` protects against the case of
passing in small widths when set to ``true``.

Below is a demonstration of how ``SliceSampler`` can be called:

.. code-block:: julia
  :linenos:

  SliceSampler()

  SliceSampler(widths=[1.5, 1.1], stepout=false)


.. _mh:

MH
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Metropolis-Hastings, to appear soon.


.. _ram:

RAM
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Robust adaptive Metropolis, to appear soon.


.. _hmc:

HMC
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Hamiltonian Monte Carlo, to appear soon.


.. _hmcda:

HMCDA
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Adaptive Hamiltonian Monte Carlo with dual averaging, to appear soon.


.. _nuts:

NUTS
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

No-U-turn sampler, to appear soon.


.. _mala:

MALA
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Metropolis-adjusted Langevin algorithm, to appear soon.


.. _smmala:

SMMALA
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Simplified manifold Metropolis-adjusted Langevin algorithm, to appear soon.


.. _rmhmc:

RMHMC
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Riemannian manifold Hamiltonian Monte Carlo, to appear soon.


.. _pmala:

PMALA
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Position-dependent Metropolis adjusted Langevin algorithm, to appear soon.
