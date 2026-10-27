{
  driver: {
    cpp: 'generate_layers',
    layers: {
      event: { parent: 'job', total: 1, starting_number: 0 },
    },
  },
  sources: {
    // Python generator: provides a particle table (creator 'pygen', suffix 'particles')
    pygen: {
      py: 'plugin_generator',
      layer: 'event',
      # You may add configuration here if you implement that within your generator
    },
  },
  modules: {
    // Particle table -> HepMC3::GenEvent (creator 'input', suffix 'genevent')
    assemble: {
      cpp: 'genevent_from_table',
      input_layer: 'event',
    },
    edep_sim_tracking: {
      cpp: 'esp_tracking',
      input_layer: 'event',
      // gdml: '/home/jacob/Downloads/protodunehd_v8_refactored.gdml',
      gdml: 'gdml/pdhd_like.gdml',
      // gdml: '/home/jacob/phlex-work/dune/xerosere/tests/edep-simphony/geometry/benchmark_small.gdml',
      // edep-sim's preamble leaves optical photons unstacked (killed) on the
      // CPU; turn scintillation stacking on so photons are tracked to the
      // photon-detector shell and land in TG4Event.PhotonDetectors.  (This is
      // the CPU optical path; the GPU plugin path is ddm-p5j.7.)
      macro: '/process/optical/scintillation/setStackPhotons false\n',
    },
    //edep_observables: {
    //  cpp: 'esp_observables',
    //  input_layer: 'event',
    //  input_from: 'edep_sim_tracking',  // consumes the TG4Event
    //},
    //hdf_out: {
    //  cpp: 'phlex_arrow_hdf_output',
    //  output_file: 'obs.h5',  // writes all Arrow-typed products
    //},
    output: {
      cpp: 'form_module',
      products: ['tg4event'],
    },
  },
}