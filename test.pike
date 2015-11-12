constant sample_size = 10000;
array sample_data = allocate (sample_size);

class MyCostFunction
{
  inherit Ceres.CostFunction;

  Ceres.ResidualBlock evaluate (array(Ceres.ParameterBlock) pbs)
  {
    Ceres.ResidualBlock rb = Ceres.ResidualBlock (sample_size);

    for (int i = 0; i < sample_size; i++) {
      rb[i] = sample_data[i] - 
	(pbs[0][0] * exp (-pbs[0][1] * i) + pbs[0][2]) +
	(pbs[1][0] * exp (-pbs[1][1] * i) + pbs[1][2]);
    }

    return rb;
  }
}

int main(int argc, array argv)
{
  float a1 = 2.2;
  float lmbda1 = 0.0125;
  float b1 = 1.1;

  float a2 = 0.53;
  float lmbda2 = 0.08;
  float b2 = 0.0;

  for (int i = 0; i < sample_size; i++) {
    sample_data[i] = 
      (a1 * exp (-lmbda1 * i) + b1) +
      (a2 * exp (-lmbda2 * i) + b2) + 
      random(0.1) - 0.05;
  }

  MyCostFunction mcf = MyCostFunction();
  Ceres.AutoDiffSolver solver = Ceres.AutoDiffSolver();

  array(array(float)) initial_params = ({ ({ 0.0, 0.0, 0.0 }),
					  ({ 0.0, 0.0, 0.0 }) });

  array(array(float)) result = solver->solve (mcf, initial_params, 1000);
  werror ("result: %O\n", result);
}
