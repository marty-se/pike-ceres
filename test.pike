void cb (array params, array res, array jac) 
{ 
  res[0] = 10 - params[0][0]; 
  if (jac && jac[0]) 
    jac[0][0][0] = -1.0; 
}

void test()
{
  for (int i = 0; i < 100; i++) {
    array parms = ({ ({ 0.5 }) });
    object p = module.Problem(cb, parms, 1);
    p->solve();
  }
}

int main(int argc, array argv)
{
  for (int i = 0; i < 20; i++)
    Thread.thread_create (test);

  array a = ({});
  while (_prev(a))
    a = _prev (a);
  while (a) {
    werror ("%O\n", a);
    a = _next (a);
  }

  werror ("%O\n", _memory_usage());


  return -1;
}
